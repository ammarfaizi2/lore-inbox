Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131417AbQLUWUL>; Thu, 21 Dec 2000 17:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131428AbQLUWUA>; Thu, 21 Dec 2000 17:20:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:260 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131417AbQLUWTv>; Thu, 21 Dec 2000 17:19:51 -0500
Date: Thu, 21 Dec 2000 15:44:46 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jmerkey@timpanogas.org, linux-kernel@vger.kernel.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
Message-ID: <20001221154446.A10579@vger.timpanogas.org>
In-Reply-To: <20001221144247.A10273@vger.timpanogas.org> <E149DKS-0003cX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E149DKS-0003cX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 21, 2000 at 09:32:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 09:32:46PM +0000, Alan Cox wrote:
> > A question related to bigphysarea support in the native Linux
> > 2.2.19 and 2.4.0 kernels.
> > 
> > I know there are patches for this support, but is it planned for 
> > rolling into the kernel by default to support Dolphin SCI and 
> > some of the NUMA Clustering adapters.  I see it there for some 
> > of the video adapters.
> 
> bigphysarea is the wrong model for 2.4. The bootmem allocator means that
> drivers could do early claims via the bootmem interface during boot up. That
> would avoid all the cruft.
> 
> For 2.2 bigphysarea is a hack, but a neccessary add on patch and not one you
> can redo cleanly as we don't have bootmem
> 
> I belive Pauline Middelink had a patch implementing bigphysarea in terms of
> bootmem
> 
> Alan

Alan,

Thanks for the prompt response.  I am merging the Dolphin SCI High Speed
interconnect drivers into 2.2.18 and 2.4.0 for our M2FS project, and I 
am reviewing the big ugly nasty patch they have current as of 2.2.13 
(really old).  I will be looking over the 2.4 tree for a more clean 
manner to do what they want.

What's in the patch alters the /proc filesystem, and the VM code.  I will
submit a patch against 2.2.19 and 2.4.0 for this support for their SCI 
adapters after I get a handle on it.

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
