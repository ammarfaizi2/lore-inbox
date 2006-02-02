Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWBBX3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWBBX3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWBBX3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:29:37 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52653 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S932466AbWBBX3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:29:36 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de,
       mrmacman_g4@mac.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Reply-To: 7eggert@gmx.de
Date: Fri, 03 Feb 2006 00:29:15 +0100
References: <5yJ3h-6er-11@gated-at.bofh.it> <5yVQR-8bI-39@gated-at.bofh.it> <5yWah-99-29@gated-at.bofh.it> <5yWts-OZ-21@gated-at.bofh.it> <5z1Wj-TN-31@gated-at.bofh.it> <5zer2-1BC-29@gated-at.bofh.it> <5AFHY-5jd-23@gated-at.bofh.it> <5ALb5-5kV-43@gated-at.bofh.it> <5B15G-39W-17@gated-at.bofh.it> <5B1Im-4cW-7@gated-at.bofh.it> <5B3TN-7AV-9@gated-at.bofh.it> <5Bs5Z-1BT-17@gated-at.bofh.it> <5BJgx-1fE-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F4nt5-00014L-Ry@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

>> It's shorter than /dev/c0t0d0s0? Well, I think it's because people think
>> in terms of connectors (my drive is IDE therefore it must be hdc) rather
>> than protocol (my drive does ATAPI therefore it must be
>> /dev/scsi/c0t0d0s0).
> 
> Is there any reason why the people with small PCs should dominate the
> people with big machines?
> 
> If you use /dev/hd*, you loose control after you add more than ~ 6-10 disks.

So you'll create a symlink. (If you're Ingvar Kamprad, it will be named bjørn.)

> The systematical attempt is easy to remember even with a big amount of
> external hardware.

If you
- add a SCSI controler
- add an USB burner
- connect to an aoe/iscsi-device(?),
it will get a random ID. If you reboot (or just plug out/plug in), it will
be randomly different. The same thing may happen after a system upgrade,
possibly depending on the linker.

In these cases, there is nothing you can remember, and you'll have to run
-scanbus in order to find out if your burner is 0.8.15 or maybe 32.16.8
_each_ time you want to burn a CD. But you _can_ remember (or write into
your config files) that it will be named /udev/cdr/LITE-ON_LTR-48246K.

Having to find out the magic number of the day is usurally worse than
using the very same name you usurally use to identify an object. If you
see an advantage, let the ATAPI bus be -3, translate -3,$n,0.0 to
"/dev/hd".chr(96+$n) and everybody will be happy.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
