Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSAQI5n>; Thu, 17 Jan 2002 03:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288384AbSAQI5d>; Thu, 17 Jan 2002 03:57:33 -0500
Received: from mailhost.iitb.ac.in ([203.197.74.142]:44817 "HELO
	mailhost.iitb.ac.in") by vger.kernel.org with SMTP
	id <S288342AbSAQI5P>; Thu, 17 Jan 2002 03:57:15 -0500
X-SMTP-Sending-IP: 144.16.116.2
Date: Thu, 17 Jan 2002 14:26:58 +0530
From: Ravindra Jaju <jaju@it.iitb.ac.in>
To: linux-kernel@vger.kernel.org
Subject: Re: Removing the whitespaces??? [Was: Re: Why not "attach" patches?]
Message-ID: <20020117142658.A8146@akash.it.iitb.ac.in>
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home> <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org> <20020115151629.N11251@lynx.adilger.int> <a22gfn$c15$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a22gfn$c15$1@forge.intermeta.de>; from hps@intermeta.de on Wed, Jan 16, 2002 at 12:11:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:11:35AM +0000, Henning P. Schmiedehausen wrote:
> apply patches. Run this. Rinse. Repeat. :-)
> 
> --- cut ---
> 
> mkdir /usr/src/linux.noblanks
> 
> (
>   cd /usr/src/linux
>   find . -type d -exec mkdir -p /usr/src/linux.noblanks/{} \;
>   for i in `find . -type f`; do
>     perl -ne 's/[        ]+$//; print;' < ${i} > /usr/src/linux.noblanks/${i}
>   done
> )
> 
> diff -ur /usr/src/linux /usr/src/linux.noblanks | mail -s "blanks removed" torvalds@transmeta.com 
> 
> rm -rf /usr/src/linux.noblanks
> --- cut ---
> 
> (This is a TAB and a space in the square brackets above. 
> Don't use \s. Trust me.)
> 
> linux-2.2.20.tar.bz2:		15,751,285 bytes
> linux-2.2.20-nbl.tar.bz2:       15,608,085 bytes
> 
> Patch Size (uncompressed):	17,815,166 bytes (yes this _is_ 17,4 MBytes)
>            (compressed, bzip2):  3,322,456 bytes 
> 
> One mega-patch to shear off about 140 KBytes from the compressed (and
> about 170 k from the unpacked (94488 vs. 94316 KBytes ) kernel source
> would (while it may be the biggest single "reduce-size-of-kernel-tree
> patch" in years :-) ) a little gross.

Uh .. why not let Linus just run this program on *his* machine, and putting
up the patch again as a "program to be run"? ;-)

Saves Linus of the headache to check if there are any bugs in the patch
before applying ( and that too, with the funny label of "lossy something"
he's earned ... saves a lot of bandwidth! ;-) )

regards,
jaju
