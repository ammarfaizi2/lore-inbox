Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262869AbRE0Xbi>; Sun, 27 May 2001 19:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbRE0Xb3>; Sun, 27 May 2001 19:31:29 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:49156 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S262869AbRE0XbV>; Sun, 27 May 2001 19:31:21 -0400
Date: Mon, 28 May 2001 11:31:16 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
Cc: stepken@little-idiot.de, linux-kernel@vger.kernel.org
Subject: Re: IDE Performance lack !
Message-ID: <20010528113116.A4895@metastasis.f00f.org>
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba> <20010527224045.B3556@metastasis.f00f.org> <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00c701c0e6d8$2b28ea40$4aa6b3d0@Toshiba>; from jaswinder.singh@3disystems.com on Sun, May 27, 2001 at 11:09:25AM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 11:09:25AM -0700, Jaswinder Singh wrote:

    But my problem is why linux boxes do not response for few seconds
    (sometimes) and especially during telnet/ssh it looks more worst
    and looks similar to Microsoft Windows :(
    
    there is problem in scheduling or what ?

Sounds like IO starvation, if your reading from one partition to the
other, it's going to suck for IO --- the head will be going nuts.
Also, 2.2.x has a single IO queue for writes (doesn't it?), so that won't
help.

What if you dd a file from one partition to another, is the problem
lesser with larger buffers, say 64M or so?

What about dd from /dev/zero to a partition, so you get heavy writes,
does this also suck?





   --cw

