Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbTGIOVO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268290AbTGIOVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:21:14 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:34432 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S268257AbTGIOVN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:21:13 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: chas@locutus.cmf.nrl.navy.mil, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: seq_file and proc_dir_entry data (was Re: [PATCH 5/8] 2.5.74 -
 seq_file conversion of /proc/net/atm (vc))
From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 09 Jul 2003 10:35:51 -0400
In-Reply-To: <20030709022946.G11897@electric-eye.fr.zoreil.com> (Francois
 Romieu's message of "Wed, 9 Jul 2003 02:29:46 +0200")
Message-ID: <87brw3epiw.fsf_-_@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <20030709021152.B11897@electric-eye.fr.zoreil.com>
	<20030709022946.G11897@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On creating a proc entry, it's possible to set the data field to an
arbitrary pointer value.  Later, that pointer value can be used in
callbacks to do interesting things, like access persistent data
associated with the proc file.

I had to rewrite seq_read so that when it calls the start operation it
passes a pointer to a struct (not an loff_t) with iterator info and
also a pointer to the proc_dir_entry data field.

Would it be possible to modify seq_file to give easier access to the
data field of proc_dir_entry, or is seq_file too general for that to
be practical?

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

