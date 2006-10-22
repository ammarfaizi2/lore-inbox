Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJVMcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJVMcd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWJVMcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:32:33 -0400
Received: from main.gmane.org ([80.91.229.2]:9386 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750863AbWJVMcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:32:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] [4th RESEND]  Remove logic error in /Documentation/devices.txt
Date: Sun, 22 Oct 2006 12:32:08 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejmpii.30t.olecom@flower.upol.cz>
References: <1161537893.3657.4.camel@mflaptop>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-22, Marcus Fischer wrote:
> Hello all,

Hallo, Marcus.

> can someone please tell me what I'm doing wrong with this commit?
> I'm lacking experience, but I thought I understood the process correct.

Yes. I think there is an error with numbering of devices set. And your
effort to fix it appreciated.

> Please send me some feedback that I can rework/modify the patch if required.
[]
> PS: Please CC me, I'm not on this list.

Add yourself there, you'll have a copy to check your patch again, or
carefully construct "Mail-Followup-To" header.

Also. If you've read top of devices.txt, you must have read about name and
e-mail of the current maintainer of that file (i've added him).
Finally one may think, this is a trivial fix, so <trivial@kernel.org>
can be e-mailed also.

> commit 51f3fe947923f6e775031cc1d538de6cf06ec77d
> Author: Marcus Fischer <linux@marcusfischer.com>
> Date:   Fri Sep 29 23:50:01 2006 +0200
>
>     I found an logic error in the following commit:
>     
>         author    Steven Haigh <netwiz@crc.id.au>
>                   Tue, 8 Aug 2006 21:42:06 +0000 (07:42 +1000)
>         committer Greg Kroah-Hartman <gregkh@suse.de>
>                   Wed, 27 Sep 2006 18:58:59 +0000 (11:58 -0700)
>         commit    03270634e242dd10cc8569d31a00659d25b2b8e7
>         tree      8f4665eb7b17386e733fcdc7d02e87c4a1592550
>         parent    8ac283ad415358f022498887811c35ac656b5222
>     
> Documentation/devices.txt may either say 
> ../adutux10 11th OntrackADU device    or 
> ../adutux9 10th Ontrack ADU device.
>
> Anyway, the original one makes no sense:
>    
> + 67 = /dev/usb/adutux0 1st Ontrak ADU device
> + ...
> + 76 = /dev/usb/adutux10 10th Ontrak ADU device
>
> This patch removes the logic error.
>
> However, I saw that MAX_DEVICES is 16.
> Thus, shouldn't this docu then say:
> "81 = /dev/usb/adutux15 16th Ontrack ADU device" ?
>
> Best,
> Marcus
>
>
>
> Signed-off-by: Marcus Fischer <linux@marcusfischer.com>
> ---

I think format of the patch isn't like suggested in "tpp", please care
to give a short view to it:
<http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt>

and if you're using git, adjust git's tools to generate needed form of a
patch. 


> diff --git a/Documentation/devices.txt b/Documentation/devices.txt
> index addc67b..37efae8 100644
> --- a/Documentation/devices.txt
> +++ b/Documentation/devices.txt
> @@ -2545,7 +2545,7 @@ Your cooperation is appreciated.
> 66 = /dev/usb/cpad0 Synaptics cPad (mouse/LCD)
> 67 = /dev/usb/adutux0 1st Ontrak ADU device
>     ...
> - 76 = /dev/usb/adutux10 10th Ontrak ADU device
> + 76 = /dev/usb/adutux9 10th Ontrak ADU device
> 96 = /dev/usb/hiddev0 1st USB HID device
>     ...
> 111 = /dev/usb/hiddev15 16th USB HID device

Good luck.
____

