Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282652AbRKZXfJ>; Mon, 26 Nov 2001 18:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282653AbRKZXfC>; Mon, 26 Nov 2001 18:35:02 -0500
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:26103
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S282652AbRKZXep>; Mon, 26 Nov 2001 18:34:45 -0500
Date: Mon, 26 Nov 2001 18:34:26 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: <nico@xanadu.home>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Nathan G. Grennan" <ngrennan@okcforum.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <E168U3m-00077F-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111261825340.15932-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Alan Cox wrote:

> > 2.4.16 becomes very unresponsive for 30 seconds or so at a time during
> > large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
> > file is about 36mb. I run top in one window, run free repeatedly in
> 
> This seems to be one of the small as yet unresolved problems with the newer
> VM code in 2.4.16. I've not managed to prove its the VM or the differing
> I/O scheduling rules however.

FWIW...

I experienced quite the same unresponsiveness but more in the order of 4-5
seconds since I started to use ext3 with RH 7.2 (i.e. kernel 2.4.7 based).  
I'm currently running 2.4.15-pre7 and the same momentary stalls are there
just like with 2.4.7. It is much more visible when applying large patches to
a kernel source tree as the patch output stops scrolling from time to time
for about 5 secs.  I never saw such thing while previously using reiserfs.  
I've yet to try reiserfs on a 2.4.16 tree to see if this is actually an ext3
problem.


Nicolas

