Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135728AbRDSV6K>; Thu, 19 Apr 2001 17:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135733AbRDSV5t>; Thu, 19 Apr 2001 17:57:49 -0400
Received: from suntan.tandem.com ([192.216.221.8]:39092 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S135728AbRDSV5i>; Thu, 19 Apr 2001 17:57:38 -0400
Message-ID: <3ADF5DCB.EEADD4E0@compaq.com>
Date: Thu, 19 Apr 2001 14:51:07 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mjacob@feral.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: active after unmount?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unmounting a SCSI disk device succeeded, and yielded:
> 
> Red Hat Linux release 6.2 (Zoot)
> Kernel 2.4.3 on a 2-processor i686
> 
> chico login: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. Have
> a nice day...
> 


This message comes out of kill_super(). I would guess that somebody's
mismanaging VFS refcounts, but there's not enough info here to diagnose the
problem. What filesystem are you using? Is this reproducible? What do you have
to do between mounting and unmounting to reproduce the problem?

--
Brian Watson
Compaq Computer
