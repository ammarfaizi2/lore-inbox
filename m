Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQKSWxf>; Sun, 19 Nov 2000 17:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129875AbQKSWx0>; Sun, 19 Nov 2000 17:53:26 -0500
Received: from 3dyn88.com21.casema.net ([212.64.94.88]:63762 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129183AbQKSWxM>;
	Sun, 19 Nov 2000 17:53:12 -0500
Date: Mon, 20 Nov 2000 00:16:52 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Cc: aeb@veritas.com
Subject: Re: 2.4 sendfile() not doing as manpage promises?
Message-ID: <20001120001652.A12969@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org, aeb@veritas.com
In-Reply-To: <20001119001558.B10579@home.ds9a.nl> <Pine.LNX.4.30.0011181513290.5897-100000@anime.net> <20001119015259.A10773@home.ds9a.nl> <20001119173623.A1185@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <20001119173623.A1185@veritas.com>; from aeb@veritas.com on Sun, Nov 19, 2000 at 05:36:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 05:36:23PM +0100, Andries Brouwer wrote:
> DESCRIPTION
>        This call copies data  between  one  file  descriptor  and
>        another.   Either  or  both  of these file descriptors may
>        refer to a socket.  in_fd  should  be  a  file  descriptor
>        opened  for  reading  and  out_fd  should  be a descriptor
>        opened for writing.
> 
> If that is incorrect, then editing a private copy of the manpage,
> as Dan Hollis, or the distributor from whom he got his page,
> seems to have done, does not suffice to change the manpage distribution.

Improved attempt:

DESCRIPTION 
	This call copies data between one file descriptor and another.  The
	descriptor from which data is read cannot be a socket but must
	correspond to a file which supports mmap()-like operations. in_fd
	should be a filedescriptor opened for reading and out_fd should be a
	descriptor opened for writing. Because this copying is done within
	the kernel, sendfile() does not need to spend time transfering data
	to and from userspace.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
