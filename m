Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVADUbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVADUbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVADUb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:31:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59828 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262158AbVADUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:30:20 -0500
Subject: Re: the umount() saga for regular linux desktop users
From: Lee Revell <rlrevell@joe-job.com>
To: Valdis.Kletnieks@vt.edu
Cc: 7eggert@gmx.de, Andy Lutomirski <luto@myrealbox.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200501022243.j02MhANg004075@turing-police.cc.vt.edu>
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no>
	 <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>
	 <200501022243.j02MhANg004075@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 15:28:44 -0500
Message-Id: <1104870524.8346.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-02 at 17:43 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 02 Jan 2005 13:38:29 +0100, Bodo Eggert said:
> 
> > Maybe it's possible to extend the semantics of umount -l to change all
> > cwds under that mountpoint to be deleted directories which will no
> > longer cause the mountpoint to be busy (e.g. by redirecting them to a
> > special inode on initramfs). Most applications can cope with that (if
> > not, they're buggy),
> 
> You mean that a program is *buggy* if it does:
> 
> 	cwd("/home/user");
> 	/* do some stuff while we get our cwd ripped out from under us */
> 	file = open("./.mycconfrc");
> 
> and expects the file to be opened in /home/user???

Yes, of course.  Any program that doesn't check the return value of a
system call is buggy.  Unless it really, really doesn't care - clearly
not the case here.

Lee

