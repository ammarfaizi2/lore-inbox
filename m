Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279336AbRJWJwF>; Tue, 23 Oct 2001 05:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279338AbRJWJwC>; Tue, 23 Oct 2001 05:52:02 -0400
Received: from [212.65.238.182] ([212.65.238.182]:47888 "EHLO
	trebo3.chemoprojekt.cz") by vger.kernel.org with ESMTP
	id <S279336AbRJWJvw> convert rfc822-to-8bit; Tue, 23 Oct 2001 05:51:52 -0400
Message-ID: <35E64A70B5ACD511BCB0000000004CA1043861@NT_CHEMO>
From: PVotruba@Chemoprojekt.cz
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.13-pre6 breaks Nvidia's kernel module
Date: Tue, 23 Oct 2001 11:52:14 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Exactly... read supplier's manuals pays well. 2.4.13-pre6+nvidia drvs
1541+GeForce2MX400 works for me perfectly.

But some other problem appeared - there's something strange probably in
nvidia framebuffer console code. Starts up nicely, X works too, including
"openuniverse", but after returning to console (regularly or by
Ctrl+Alt+Backspace), I see few standard messages and box gets frozen. 
Background sound playing also stops (it repeats playing last data in
buffer). Keyboard driver works (num+scr+caps locks are reacting at least),
but is ignored by the system. Command line also doesn't appear.

I didn't try to log into via network, cause my second box is presently not
complete, anyway I wouldn't expect any reaction from such frozen box.

Well, I stopped using nvidia framebuffer console driver and all works
nicely.
---
Some time ago I had BIG troubles with AGP working at 4X - I had to degrade
AGP to 2X (in BIOS) and all works fine now (but slower, of course).Also
kernel compilation in X terminal made system freezed, but not so badly as
the console driver did - I was still able to login via network, just to see
that X server makes 100% load, is not killable and the system ignores
shutdown commands...

My GeForce card is manufactured by some Manli company, and I use it with ECS
K7VZA board (older 686A model).
Hard to say if problem is in card or motherboard. 250VA power source could
be strong enough to drive everything...

	bye
	Petr
>  
> 
> -----Pùvodní zpráva-----
> Od:	Jesper Juhl [SMTP:juhl@eisenstein.dk]
> Odesláno:	23. øíjna 2001 11:06
> Komu:	jarausch@belgacom.net
> Kopie:	linux-kernel@vger.kernel.org
> Pøedmìt:	Re: 2.4.13-pre6 breaks Nvidia's kernel module
> 
> 
> jarausch@belgacom.net wrote:
> 
> > Hello,
> > 
> > yes I know, you don't like modules without full sources available.
> > But Nvidia is the leading vendor of video cards and all 2.4.x
> > kernels up to 2.4.13-pre5 work nice with this module.
> > 
> > Running pre6 I get
> > (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> > (EE) NVIDIA(0): Failed to allocate LUT context DMA
> > (EE) NVIDIA(0):  *** Aborting ***
> > 
> > 
> > This is Nvidia's 1.0-1541 version of its Linux drivers
> 
> I use the same version of the driver with my Geforce3 and I am also 
> running 2.4.13-pre6 and it works just fine so I don't agree with you 
> that it breaks...
> You do know that there are a few files that need to be recompiled every 
> time you build a new kernel - right?
> 
> See "http://www.nvidia.com/docs/lo/1021/SUPP/README.txt" for details.
> 
> Here's a quote from that file explaining what I do myself - that should 
> work for you:
> 
> "
> INSTALLING/UPGRADING BY TAR FILE Instructions for the Impatient:
>  
>        $ tar xvzf NVIDIA_kernel.tar.gz
>        $ tar xvzf NVIDIA_GLX.tar.gz
>        $ cd NVIDIA_kernel
>        $ make install
>        $ cd ../NVIDIA_GLX
>        $ make install
>  
> Instructions:
> 
> To install from tar file, unpack each file:
>        $ tar xvzf NVIDIA_kernel.tar.gz
>        $ tar xvzf NVIDIA_GLX.tar.gz
> 
> cd into the NVIDIA_kernel directory.  Type 'make install'.  This will
> compile the kernel interface to the NVdriver, link the NVdriver, copy
> the NVdriver into place, and attempt to insert the NVdriver into the
> running kernel:
> 
>        $ cd NVIDIA_kernel
>        $ make install
> 
> Next, move into the NVIDIA_GLX directory.  Type 'make install' -- this
> will copy the needed OpenGL and XFree86 files into place:
>        $ cd ../NVIDIA_GLX
>        $ make install
> 
> Note that the "make install" for each package will remove any previously
> installed NVIDIA drivers.
> "
> 
> 
> Best regards,
> Jesper Juhl
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
