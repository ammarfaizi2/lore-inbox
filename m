Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266123AbRGPFHm>; Mon, 16 Jul 2001 01:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbRGPFHc>; Mon, 16 Jul 2001 01:07:32 -0400
Received: from ppp37.ts3.Gloucester.visi.net ([206.246.230.165]:44026 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S266123AbRGPFHP>; Mon, 16 Jul 2001 01:07:15 -0400
Date: Mon, 16 Jul 2001 01:07:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib
Message-ID: <20010716010712.B6609@visi.net>
In-Reply-To: <Pine.LNX.4.33.0107160548400.3655-100000@tahallah.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33.0107160548400.3655-100000@tahallah.demon.co.uk>; from alex.buell@tahallah.demon.co.uk on Mon, Jul 16, 2001 at 05:50:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2001 at 05:50:12AM +0100, Alex Buell wrote:
> I just found a pair of '..' directories in the /lib directory. e2fsck 1.19
> didn't even pick up on this!
> 
> /lib
>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
> 
> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.

ls -aQ


I bet that file has atleasy one space after the "..". The -Q makes ls
enclose the filename in double-quotes.

I'de be worried if this were actually the case, and check the contents
of that file. It's a common way for someone to "hide" files when they
crack a system.


Ben

-- 
 -----------=======-=-======-=========-----------=====------------=-=------
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
