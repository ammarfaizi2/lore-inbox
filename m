Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbREPIaR>; Wed, 16 May 2001 04:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbREPIaH>; Wed, 16 May 2001 04:30:07 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:26378 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261827AbREPIaD>; Wed, 16 May 2001 04:30:03 -0400
Message-ID: <3B023A68.9B9F7D0F@idb.hist.no>
Date: Wed, 16 May 2001 10:29:28 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: James Simmons <jsimmons@transvirtual.com>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151036490.22038-100000@www.transvirtual.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > > I would use write except we use write to draw into the framebuffer. If I
> > > write to the framebuffer with that data the only thing that will happen is
> > > I will get pretty colors on my screen.
> >
> > Yes. And we also use write to send data to printer. So what? Nobody makes
> > you use the same file.
> 
> Well creating a new device wouldn't make linus happen right now. I do
> agree ioctl calls are evil!!!! You only have X amount of them. With write
> you can have infinte amounts of different functions to perform on a
> device. I didn't design fbdev :-( If I did it would have been far
> different. I do plan on some day merging drm and fbdev into one interface. So
> I plan to change this behavior. I like to see this interface ioctl-less
> (is their such a word ???). You mmap to alter buffers. Mmap is much more
> flexiable than write for graphics buffers anyways. You use write to pass
> "data" to the driver.

mmap is fine for a fb, but please don't remove read/write.
I can now do a screendump with "cat /dev/fb/0 > file", 
because everything is a file.
Having 
/dev/fb/0/brightness
/dev/fb/0/opengl
and so on seems to be a better approach.

Helge Hafting
