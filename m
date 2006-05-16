Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWEPRbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWEPRbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWEPRbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:31:35 -0400
Received: from terminus.zytor.com ([192.83.249.54]:28298 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932167AbWEPRbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:31:35 -0400
Message-ID: <446A0C68.20604@zytor.com>
Date: Tue, 16 May 2006 10:31:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Leopold Gouverneur <lgouv@tele2.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm1 panic on boot
References: <20060516001501.GA7528@localhost> <e4c3fi$utm$1@terminus.zytor.com> <20060516165054.GA8192@localhost>
In-Reply-To: <20060516165054.GA8192@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leopold Gouverneur wrote:
>
>> This means kinit couldn't find a name-to-number mapping for the string
>> /dev/hda8.  However, you said you tried vanilla rc4 with the same
>> result, and vanilla rc4 doesn't use klibc.
> Sorry for my silliness, actually rc4 boot OK
>> This means hda8 simply isn't discovered on your system, which probably
>> means hda isn't discovered.  This typically is an issue with your
>> kernel configuration, but it's not always.
> yes that was my problem: rc4-mm1 need CONFIG_SCSI_PATA_AMD=y
> which -rc4 don't for my nForce2 ide controller.
> 

Excellent, glad to hear that it was that simple.

	-hpa

