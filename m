Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWDZOm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWDZOm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWDZOm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:42:28 -0400
Received: from EXCHG2003.microtech-ks.com ([24.124.14.122]:52730 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932456AbWDZOm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:42:27 -0400
Message-ID: <444F86D2.7030000@atipa.com>
Date: Wed, 26 Apr 2006 09:42:26 -0500
From: Roger Heflin <rheflin@atipa.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
References: <8E8F647D7835334B985D069AE964A4F7011B2606@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7011B2606@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Apr 2006 14:34:22.0061 (UTC) FILETIME=[823DB9D0:01C6693E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> I think I might be having the "same type of bug" or something related using sata_via?
> Bug opened at bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=6317
> 
> This started appearing with 2.6.16.  It often does it using only one SATA HD.  It does not do it at every boot but often starts doing it after a little while (a few hours...) and finally hanging my PC.
> 
> - vin
> 
>

I can duplicate my problem everything, and I can make it stop a will.

doing "dd if=/dev/sda of=/dev/null bs=64k &"

and then

        "dd if=/dev/sdb of=/dev/null bs=64k &"

will cause the problem within a couple of seconds.

Doing "kill %1 %2" (assuming the dd's are %1 and %2) will
stop the machine from hanging on disk io within 30-60 seconds.

Once it hangs it does not appear to do any disk io until the
offending processes are killed.

                               Roger
