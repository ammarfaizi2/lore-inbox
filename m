Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbUCSPCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 10:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263013AbUCSPCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 10:02:35 -0500
Received: from kruuna.helsinki.fi ([128.214.205.14]:15750 "EHLO
	kruuna.Helsinki.FI") by vger.kernel.org with ESMTP id S263014AbUCSPCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 10:02:32 -0500
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200403191455.i2JEt0D8011309@kruuna.Helsinki.FI>
Subject: [biocenter.helsinki.fi #2456] LVM2 problems with device mapper
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Date: Fri, 19 Mar 2004 16:55:00 +0200 (EET)
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to upgrade a machine to the 2.6.4 kernel.  I have a problem
with LVM, though, and it's preventing me from getting anywhere with this.

I've installed the LVM2 kit v2.00.08.

I've built the device mapper as a module.  The module loads without any
problems.  I am not using devfs, so I ran the devmap_mknod.sh script to
create the /dev/mapper/control device, which became c 10 63.

After this, running vgscan --mknodes finds the existing volume groups
with LVM1 metadata, but complains about not being able to access the
mapper control device.

Running vgchange -a y complains about not being able to access the
mapper control device and fails altogether.

I also tried rebuilding the kernel with the patches from
http://people.sistina.com/~thornber/patches/.  The device mapper module
version changed from 4.0.0 to 4.1.0.  No new error messages, but still
no functionality either.

If it's of any consequence, the machine is a Fujitsu-Siemens RX800 8-
way with the IBM Summit x440 chipset.  Support for the Summit x440 has
naturally been enabled in the kernel.

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
