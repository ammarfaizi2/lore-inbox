Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267103AbTA0Oys>; Mon, 27 Jan 2003 09:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTA0Oys>; Mon, 27 Jan 2003 09:54:48 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:31616 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267103AbTA0Oyr>; Mon, 27 Jan 2003 09:54:47 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15925.19044.837892.463363@laputa.namesys.com>
Date: Mon, 27 Jan 2003 18:04:04 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Digeo.COM>, Alexander Viro <viro@math.psu.edu>
Subject: Re: possible deadlock in sys_pivot_root()?
In-Reply-To: <15925.15947.576552.209252@laputa.namesys.com>
References: <15925.15947.576552.209252@laputa.namesys.com>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
Emacs: no job too big... no job.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov writes:
 > Hello,
 > 
 > sys_pivot_root() first takes BKL, then ->i_sem on the old root
 > directory. On the other hand, vfs_readdir() first takes ->i_sem on a
 > directory and then calls file system ->readdir() method, that usually
 > takes BKL. Isn't there a deadlock possibility? Of course,

Should think more before posting. Special treatment of BKL by scheduler
makes this impossible.

Nikita.
