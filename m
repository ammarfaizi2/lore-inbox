Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279328AbRJWJN7>; Tue, 23 Oct 2001 05:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279329AbRJWJNt>; Tue, 23 Oct 2001 05:13:49 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:5895 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S279328AbRJWJNb>; Tue, 23 Oct 2001 05:13:31 -0400
Message-ID: <3BD532EC.6080803@eisenstein.dk>
Date: Tue, 23 Oct 2001 11:05:48 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: jarausch@belgacom.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jarausch@belgacom.net wrote:

> Hello,
> 
> yes I know, you don't like modules without full sources available.
> But Nvidia is the leading vendor of video cards and all 2.4.x
> kernels up to 2.4.13-pre5 work nice with this module.
> 
> Running pre6 I get
> (==) NVIDIA(0): Write-combining range (0xf0000000,0x2000000)
> (EE) NVIDIA(0): Failed to allocate LUT context DMA
> (EE) NVIDIA(0):  *** Aborting ***
> 
> 
> This is Nvidia's 1.0-1541 version of its Linux drivers

I use the same version of the driver with my Geforce3 and I am also 
running 2.4.13-pre6 and it works just fine so I don't agree with you 
that it breaks...
You do know that there are a few files that need to be recompiled every 
time you build a new kernel - right?

See "http://www.nvidia.com/docs/lo/1021/SUPP/README.txt" for details.

Here's a quote from that file explaining what I do myself - that should 
work for you:

"
INSTALLING/UPGRADING BY TAR FILE Instructions for the Impatient:
 
       $ tar xvzf NVIDIA_kernel.tar.gz
       $ tar xvzf NVIDIA_GLX.tar.gz
       $ cd NVIDIA_kernel
       $ make install
       $ cd ../NVIDIA_GLX
       $ make install
 
Instructions:

To install from tar file, unpack each file:
       $ tar xvzf NVIDIA_kernel.tar.gz
       $ tar xvzf NVIDIA_GLX.tar.gz

cd into the NVIDIA_kernel directory.  Type 'make install'.  This will
compile the kernel interface to the NVdriver, link the NVdriver, copy
the NVdriver into place, and attempt to insert the NVdriver into the
running kernel:

       $ cd NVIDIA_kernel
       $ make install

Next, move into the NVIDIA_GLX directory.  Type 'make install' -- this
will copy the needed OpenGL and XFree86 files into place:
       $ cd ../NVIDIA_GLX
       $ make install

Note that the "make install" for each package will remove any previously
installed NVIDIA drivers.
"


Best regards,
Jesper Juhl


