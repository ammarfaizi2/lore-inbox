Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315461AbSEGOI2>; Tue, 7 May 2002 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315462AbSEGOI1>; Tue, 7 May 2002 10:08:27 -0400
Received: from ns.suse.de ([213.95.15.193]:38665 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315461AbSEGOI0>;
	Tue, 7 May 2002 10:08:26 -0400
Date: Tue, 7 May 2002 16:08:25 +0200
From: Dave Jones <davej@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
Message-ID: <20020507160825.S22215@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 02:57:46PM +0100, Anton Altaparmakov wrote:
 > How do I get this information with hdparm please?
 > 
 > [aia21@drop ide]$ cat via

Bartlomiej Zolnierkiewicz moved all this stuff to userspace
a long time ago in 'ideinfo'.

 > [aia21@drop hda]$ cat cache
 > 1916
 > [aia21@drop hda]$ cat capacity
 > 80418240
 > [aia21@drop hda]$ cat geometry
 > physical     79780/16/63
 > logical      5005/255/63
 > 
 > And hdparm never gives you the physical geometry AFAICS.

Why would a normal user ever need to know this info?

 > And as I said, I can understand removing the ability to write values into 
 > /proc/ide/*, what I disagree with is the removal of the information 
 > provided by read-only access to /proc/ide/*. And that is because I am not 
 > aware of any other way to get the same information.

The parsing gunk we have for /proc/ide is fugly, and should have been
done with sysctls from day one imo.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
