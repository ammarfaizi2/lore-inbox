Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129882AbQK2BJj>; Tue, 28 Nov 2000 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130363AbQK2BJ3>; Tue, 28 Nov 2000 20:09:29 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:58383 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129882AbQK2BJN>; Tue, 28 Nov 2000 20:09:13 -0500
Date: Wed, 29 Nov 2000 01:37:22 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test: rmmod -a without effect
Message-ID: <20001129013721.C1777@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a 2.4.0-test11 system;
rmmod -a (modutils-2.3.21) fails to unload unused autocleanable modules:
modprobe -r behaves the same, BTW

root@cantaloupe:~ > lsmod
Module                  Size  Used by
ppp_deflate            44736   0  (autoclean) (unused)
ppp_generic            25728   0  (autoclean) [ppp_deflate]
root@cantaloupe:~ > rmmod -a
root@cantaloupe:~ > lsmod
Module                  Size  Used by
ppp_deflate            44736   0  (autoclean) (unused)
ppp_generic            25728   0  (autoclean) [ppp_deflate]

As the binary does just a syscall delete_module(0), I guess it's the
kernel's fault. Same behaviour with 2.4.0-test9 and -test11-ac2.

Is this known and to be expected?

Regards,
-- 
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
