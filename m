Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267669AbUH0Xl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267669AbUH0Xl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbUH0Xk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:40:56 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:42848 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267368AbUH0XkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:40:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, grendel@caudium.net
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Date: Fri, 27 Aug 2004 18:40:03 -0500
User-Agent: KMail/1.6.2
Cc: "Nemosoft Unv." <webcam@smcc.demon.nl>, Linus Torvalds <torvalds@osdl.org>,
       Craig Milo Rogers <rogers@isi.edu>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>
References: <20040826233244.GA1284@isi.edu> <200408272342.30619@smcc.demon.nl> <20040827224937.GA5107@beowulf.thanes.org>
In-Reply-To: <20040827224937.GA5107@beowulf.thanes.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408271840.04219.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 05:49 pm, Marek Habersack wrote:
> On Fri, Aug 27, 2004 at 11:42:30PM +0200, Nemosoft Unv. scribbled:
> [snip]
> > > So I'd personally much prefer the user mode approach. At that point it's
> > > still closed-source, but at least there is not even a whiff of a "hook"
> > > inside the kernel.
> > 
> > My problem with that is that it makes using such cams a lot harder for both 
> > users and developers of webcam tools. Basicly, every tool that wanted to 
> > use webcam X that has some binary-only library would need to specifically 
> > support it, use probing routines, check which formats are supported, set up 
> > the decompressor, push the data through it, etc. Conversely, every user 
> > that wanted to use webcams X, Y and Z would need to check first if they are 
> > all supported by the program(s) he would like to use.
> Forgive me if I'm talking bullshit, but wouldn't it be possible for you to
> route the stream through a device with an entry in /dev/ which would be
> opened by a userspace daemon which would take the stream from the in-kernel
> pwc driver, apply all the codec magic to it, and then give it back to the
> driver in the kernel so that the application that grabs the frames would get
> the processed data? That way you would need only one userlevel daemon to
> support the codecs and all the other apps would just read the data from the
> framebuffer.
> 

I wonder if something like uinput is possible/desirable for v4l?

-- 
Dmitry
