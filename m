Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269870AbTGKKgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 06:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269878AbTGKKgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 06:36:49 -0400
Received: from oasis.frogfoot.net ([168.210.54.51]:51876 "HELO
	oasis.frogfoot.net") by vger.kernel.org with SMTP id S269870AbTGKKgr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 06:36:47 -0400
Date: Fri, 11 Jul 2003 12:49:57 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Subject: poll file operation parameters
Message-ID: <20030711104957.GA25957@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Discussions <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: application/pgp; x-action=sign; format=text
Content-Disposition: inline; filename="msg.pgp"
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks CC
X-Operating-System: Debian GNU/Linux oasis 2.4.21 (i686)
X-GPG-Public-Key: http://oasis.frogfoot.net/keys/
X-Uptime: 12:46:39 up 5 days, 12:53, 7 users, load average: 0.00, 0.03, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Is it valid if a driver's poll file operation is called with a NULL poll_table
parameter, i.e. if you have

static int drv_poll (void *id,struct file *file,poll_table *table)
{
	BUG_ON( id==NULL || file==NULL || table==NULL );
	...
}	

Is above valid or may table indeed be NULL?

- -- 

Regards
 Abraham

You mean now I can SHOOT YOU in the back and further BLUR th'
distinction between FANTASY and REALITY?

___________________________________________________
 Abraham vd Merwe - Frogfoot Networks CC
 9 Kinnaird Court, 33 Main Street, Newlands, 7700
 Phone: +27 21 686 1665 Cell: +27 82 565 4451
 Http: http://www.frogfoot.net/ Email: abz@frogfoot.net

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Debian :: The Universal Operating System

iD8DBQE/DpZV0jJV70h31dERAtBcAJ9ba7mI5mVh6bLVdiKqgwN7b3oGrQCfc9mG
Gfr2HOuZlDs8DVx7gr2UAUg=
=eHJf
-----END PGP SIGNATURE-----
