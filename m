Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbTCGLwQ>; Fri, 7 Mar 2003 06:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCGLwQ>; Fri, 7 Mar 2003 06:52:16 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:31401 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261542AbTCGLwP>; Fri, 7 Mar 2003 06:52:15 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15976.35433.135732.310826@laputa.namesys.com>
Date: Fri, 7 Mar 2003 15:02:49 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Patrick Mochel <mochel@osdl.org>
Cc: Dominik Brodowski <linux@brodo.de>, <linux-kernel@vger.kernel.org>
Subject: Re: sys/fs and sys/block
In-Reply-To: <Pine.LNX.4.33.0303051035100.994-100000@localhost.localdomain>
References: <20030305083932.GA792@brodo.de>
	<Pine.LNX.4.33.0303051035100.994-100000@localhost.localdomain>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-NSA-Fodder: Clinton Panama ECHELON Kenneth Starr cryptographic Nazi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:
 > 

[...]

 > 
 > >From the original author: 
 > 
 > "Also, struct kobject is embedded into struct super_block. It is
 > naturally file system responsibility to register it (and may be some
 > other kobject's) at mount, and unregister at umount."

I (the original author) think it is cleaner to leave initialization and
registering of this kobject to the file system back end. For example,
there is no obvious generic way to generate names for such objects, etc.

 > 
 > I wonder if it can, and should, be done automatically. Or, if we can just 
 > use symlinks to point to the partitions, instead of creating a new object 
 > at all. 

Err. Not sure I understand. kobject representing file system instance
would probably have completely different set of attributes than
underlying partition object. Then, there are !FS_REQUIRES_DEV file
systems.

 > 
 > Thanks for the questions,
 > 

Nikita.

 > 
 > 	-pat
