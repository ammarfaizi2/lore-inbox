Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbREQATW>; Wed, 16 May 2001 20:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbREQATM>; Wed, 16 May 2001 20:19:12 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:41481 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261277AbREQATJ>; Wed, 16 May 2001 20:19:09 -0400
Date: Thu, 17 May 2001 02:11:21 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: siva prasad <si_pras@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010517021119.C12745@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010516150538.20451.qmail@web13703.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010516150538.20451.qmail@web13703.mail.yahoo.com>; from si_pras@yahoo.com on Wed, May 16, 2001 at 08:05:38AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 08:05:38AM -0700, siva prasad wrote:
> Is it true that the ipc calls like
> msgget(),shmget()...
> are  not really system calls?

No, they all use a system call, but the system call is the same for all
functions.

> Cos in the file "asm/unistd.h" where the
> system calls are listed as __NR_xxx we dont find
> the appropriate listing for the ipc calls.
> What I guessed was that all the ipc calls are
> clubbed under the 'int ipc()' system call and this
> is well listed in the "asm/unistd.h" 

Right, they all use __NR_ipc. See sys_ipc() in
arch/i386/kernel.sys_i386.c, especially the comment right above the
function...

> Could some one explain why the ipc is implemented 
> this way rather that implementing them as individual 
> system calls as in UNIX.

Probably because the original designer liked it this way and nobody
cared enough to do it otherwise.

> Or is it the same way in UNIX

I don't know, I don't have Unix source available.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
