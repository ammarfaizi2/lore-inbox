Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbUK1LSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbUK1LSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 06:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbUK1LSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 06:18:14 -0500
Received: from main.gmane.org ([80.91.229.2]:42439 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261433AbUK1LSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 06:18:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Date: Sun, 28 Nov 2004 11:18:07 +0000 (UTC)
Message-ID: <slrncqjcve.19r.psavo@varg.dyndns.org>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10> <slrncqhqib.19r.psavo@varg.dyndns.org> <33262.192.168.0.2.1101597468.squirrel@192.168.0.10>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Fritzsche <tf@noto.de>:
> the error message you receive means that your device don't support the SET
> STREAMING command. But I'm wondering because an other user reported
> success with exactly the DVD model you have. Do you use the latest FW? Do
> you have any other special software / hardware setup that could explain
> this difference?

I updated firmware today to F506 (from F502). Same answer as before.

FWIW, the drive doesn't support setcd -command either.

> What Kernel do you use?

Linux tienel 2.6.10-rc2-mm1 #1 SMP Wed Nov 17 01:19:53 EET 2004 i686 GNU/Linux

Actually now that I rebooted (for DVD flashing) and started back into
linux, after running dvdspeed it also says:
"scsi: unknown opcode 0xb6" (which is SET_STREAMING). Code for this is
in drivers/block/scsi_ioctl.c, and if I read it right, it can't prevent
root from executing that command.

I modified your speed-1.0 to open device O_RDWR, didn't help.
I modified it to also dump_sense after CMD_SEND_PACKET, it's just
duplicate packet.


Thanks.
-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

