Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEaIqL>; Fri, 31 May 2002 04:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315232AbSEaIqK>; Fri, 31 May 2002 04:46:10 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:49816 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S311710AbSEaIqJ>; Fri, 31 May 2002 04:46:09 -0400
Date: Fri, 31 May 2002 10:45:59 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: erc@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is the linux networking code broken?
Message-ID: <20020531104559.A23756@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: erc@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020531064959.GD1402@riesen-pc.gr05.synopsys.com> <20020531024623.K4707-101000@ranger.pns.bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 02:47:21AM -0500, Ed Carp wrote:
> On Fri, 31 May 2002, Alex Riesen wrote:
> 
> > Neither of them. How do you think the things are working here? 8-)
> > rsync, wget, apache, a whole lot other programs transfer megabytes.
> 
> Most of them use short writes.  Here's the source I'm using...

Most of them are the biggest possible writes.

~/compile/ercftp ./sender localhost ../nfs-kaboom.c
Using 2048 byte packets
Connecting to localhost
Resolved, opening TCP socket
Doing connect
Connected, waiting for OK...
Waiting for OK...
Sending ../nfs-kaboom.c
... a while
Waiting for ack...
caught signal 14!


~/compile/ercftp ./receiver 
Getting TCP socket
Doing bind
Doing listen
Accepting connection
Writing 23987 to ../nfs-kaboom.c
... another while

caught signal 14! flen=23987, inlen=0, pos=0, packets=12, packet.seqno=0


Neither of the programs finished because of awful lot of bugs within,
but the output clearly shows the facts.
Surely, no problems with networking observed.

What kernel do you use? Also, you may want check your system libraries
(libc, libresolv*).

-alex
