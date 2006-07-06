Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWGFIcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWGFIcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWGFIcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:32:08 -0400
Received: from baikonur.stro.at ([213.239.196.228]:5059 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S965093AbWGFIcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:32:06 -0400
Date: Thu, 6 Jul 2006 10:31:57 +0200
From: maximilian attems <maks@sternwelten.at>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, klibc@zytor.com,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Message-ID: <20060706083157.GD2160@baikonur.stro.at>
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <klibc.200606272217.30@tazenda.hos.anvin.org> <200607060940.40678.ncunningham@linuxmail.org> <44AC551B.8090204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AC551B.8090204@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:11:07PM -0700, H. Peter Anvin wrote:
> Nigel Cunningham wrote:
> > 
> > This patch doesn't look right to me. After it is applied, the user will have 
> > no way of saying that they don't want to resume (noresume). I assume the 
> > removal of resume= isn't a problem because you're expecting them to use that 
> > other undocumented way of setting resume= that Pavel mentioned a while ago?
> > 
> 
> Yes, they have.  The handing of resume= and noresume are now done in 
> kinit; resume is invoked from userspace by direct command only.

the grumble on kinit is that it is a big monolithic bin.
You have no scriptability and it is not modular.
Very useful pieces out of kinit are not build standalone:
initrd_load, ramdisk_load, do_mounts_md, ..

-- 
maks
