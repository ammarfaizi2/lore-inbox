Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287000AbRL1Uga>; Fri, 28 Dec 2001 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287017AbRL1UgV>; Fri, 28 Dec 2001 15:36:21 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:8453 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S287012AbRL1UgG>; Fri, 28 Dec 2001 15:36:06 -0500
Date: Fri, 28 Dec 2001 22:36:04 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Roy Hills <linux-kernel-l@nta-monitor.com>, linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20011228223604.A370@elektroni.ee.tut.fi>
Mail-Followup-To: Roy Hills <linux-kernel-l@nta-monitor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228121228.GA9920@emma1.emma.line.org> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <a0iee9$s90$1@cesium.transmeta.com> <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1> <E16K1bW-0001K0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16K1bW-0001K0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 28, 2001 at 06:19:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 06:19:38PM +0000, Alan Cox wrote:
> > Does anyone know the status of zImage format in modern kernels?
> > Is it _supposed_ to be supported under 2.2.recent?  How about 2.4.recent?
> 
> It works for me. It is meant to work

On Fri, Dec 28, 2001 at 10:42:17AM -0800, H. Peter Anvin wrote:
> I don't think there is any reason to believe zImage doesn't work
> unless bzImage works on your system.

Hi, I was one that reported the problem that zImage doesn't work. I don't
personally care whether it works or not because bzImages are fine for my
machines. Anyway, 2.2.20pre3 was ok but 2.2.20pre5 was not. I just rechecked
with 2.2.20 final. I compiled 2.2.20 'make zImage; make bzImage' for one old
486 and for one pentium. Both print Out of memory and System halted for the
zImages and work fine with bzImages.

486:

Memory: 47176k/49152k available (796k kernel code, 408k reserved, 728k data, 44k init)
   text    data     bss     dec     hex filename
 853655   90740  125288 1069683  105273 vmlinux
-rwxr-xr-x    1 kaukasoi users     1111776 Dec 28 21:46 vmlinux
-rw-r--r--    1 kaukasoi users      458880 Dec 28 21:46 bzImage
-rw-r--r--    1 kaukasoi users      458877 Dec 28 21:46 zImage

pentium:

Memory: 63516k/65536k available (736k kernel code, 416k reserved, 828k data, 40k init)
   text    data     bss     dec     hex filename
 788441   90140  105768  984349   f051d vmlinux
-rwxr-xr-x    1 kaukasoi users     1098107 Dec 28 22:04 vmlinux
-rw-r--r--    1 kaukasoi users      442277 Dec 28 22:04 bzImage
-rw-r--r--    1 kaukasoi users      442277 Dec 28 22:04 zImage

I compiled them with gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2
release) and binutils 2.11.90.0.19 (tehy are the versions that come with
Slackware 8.0). The pentium uses LILO version 19 and the 486 uses version
21.7-5.

If you think those are too large kernels for zImage, e.g. this 2.2.19 works
ok on the 486:
-rw-r--r--    1 root     root       476269 Aug 11 23:32 zImage
Memory: 47136k/49152k available (832k kernel code, 412k reserved, 728k data, 44k init)
