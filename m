Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWGFIjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWGFIjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWGFIjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:39:48 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48014 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964993AbWGFIjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:39:47 -0400
Message-ID: <44ACCBCE.30502@zytor.com>
Date: Thu, 06 Jul 2006 01:37:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: maximilian attems <maks@sternwelten.at>
CC: Nigel Cunningham <ncunningham@linuxmail.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] [klibc 30/31] Remove in-kernel resume-from-disk invocation
 code
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.30@tazenda.hos.anvin.org> <200607060940.40678.ncunningham@linuxmail.org> <44AC551B.8090204@zytor.com> <20060706083157.GD2160@baikonur.stro.at>
In-Reply-To: <20060706083157.GD2160@baikonur.stro.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
>>>
>> Yes, they have.  The handing of resume= and noresume are now done in 
>> kinit; resume is invoked from userspace by direct command only.
> 
> the grumble on kinit is that it is a big monolithic bin.
> You have no scriptability and it is not modular.
> Very useful pieces out of kinit are not build standalone:
> initrd_load, ramdisk_load, do_mounts_md, ..
> 

Some of that is due to data structures, but most certainly could be 
factored out, and really should be.  Since, apparently, klibc got 
rejected for 2.6.18 we have some time to improve that situation.

For total size reasons I'm pretty sure we need to still provide a single 
binary.  The trunk code, however, needs to be clean enough that it can 
be easily modified, too.

	-hpa
