Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbRETO0s>; Sun, 20 May 2001 10:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbRETO01>; Sun, 20 May 2001 10:26:27 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:16359 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S261394AbRETO0P>; Sun, 20 May 2001 10:26:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending Device Num
Date: Sun, 20 May 2001 16:27:01 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105200925370.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01052016270101.00755@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 May 2001 15:40, Alexander Viro wrote:
> > ctlfd = open_device_control_fd(fd);
> > If fd is something that doesn't have a control interface (say, it already
> > is a control filehandle), this returns an appropriate error code.
> It may have several. Which one?


That's why I proposed using multi-stream files. With a syscall like

fd2 = open_substream(fd, "somename")

you could have several control streams and also be prepared if you want to 
support multi-stream filesystems like NTFS in the future...

BTW: how does this work in NT? Do you first open a file and then fork it like 
in my example,  do they have a special open for substreams or is the 
substream always encoded in the filename?

bye...
