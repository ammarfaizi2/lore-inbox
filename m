Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTLCU5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbTLCU5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:57:51 -0500
Received: from scrye.com ([216.17.180.1]:13999 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261569AbTLCU5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:57:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 3 Dec 2003 13:57:27 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
Subject: Re: aacraid and large memory problem (2.6.0-test11)
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Message-Id: <20031203205730.88B7EF7C86@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Bill> | > Perhaps this patch in 2.6.0-test9 is the culprit?  | >
Bill> http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c
Bill> | | This patch is what made aacraid work with over 4 gig of
Bill> memory for me. | I have an 8 proc system with 16gig of memory
Bill> and without this patch I | get data corruption in high memory.
Bill> | | I don't boot on the aacraid though.

Bill> It would be interesting to know what memory model is being used
Bill> in each case. Both CONFIG_HIGHMEM* and maybe user/kernel split
Bill> might play.

I am using the 2.6.0 rpms from:

http://people.redhat.com/arjanv/2.5/

Specifically its:

http://people.redhat.com/arjanv/2.5/RPMS.kernel/kernel-smp-2.6.0-0.test11.1.99.i686.rpm

The  kernel-2.6.0-test11-i686-smp.config
says: 

# CONFIG_NOHIGHMEM is not set
# CONFIG_HIGHMEM4G is not set
CONFIG_HIGHMEM64G=y
CONFIG_HIGHMEM=y
CONFIG_BLK_DEV_UMEM=m
CONFIG_DEBUG_HIGHMEM=y

Bill> Based on one boot with one machine, 4G RAM, it didn't hang.
Bill> Unfortunately a production machine, I was playing following some
Bill> "unscheduled maintenence."  

Did you have HIGHMEM set?

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE/zk463imCezTjY0ERAuboAKCN4XxByy8NO7UUK2h1eyXtbBIjZgCfSj9M
budyunjfaRG+UhhSHR3IZss=
=uXXJ
-----END PGP SIGNATURE-----
