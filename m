Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUEFP2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUEFP2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUEFP0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:26:05 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43400
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262625AbUEFPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:25:55 -0400
From: Rob Landley <rob@landley.net>
To: Christoph Hellwig <hch@infradead.org>, Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.5.1
Date: Tue, 4 May 2004 20:49:08 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200405030111.49802.mmazur@kernel.pl> <20040503194757.A13711@infradead.org>
In-Reply-To: <20040503194757.A13711@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405042049.08742.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 May 2004 13:47, Christoph Hellwig wrote:
> On Mon, May 03, 2004 at 01:11:49AM +0200, Mariusz Mazur wrote:
> > Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> > Changes:
> > - network headers got fixed - most notably removed most common collisions
> > between glibc and llh (I hate making hacks, but don't have much choice -
> > glibc's network headers lack functionality); iproute2 and iputils should
> > build with just small patches (which can be found at the above url) and
> > including linux/{in*,if*} in general should be quite safe now
>
> Maybe someone should spend some time and fix up the glibc headers instead?
> :)

So you think the uclibc users should be getting their headers from glibc then?

I don't.  I like this work, and intend to integrate it into some systems I'm 
putting together, after I get all the rest of the busybox bugs shaken out.  
(Well, not always bugs.  Lots of it's missing functionality.  I'm using 
busybox to replace coreutils, bzip2, findutils, grep, sed, tar, util-linux, 
and so on...  And then adding binutils and gcc and trying to compile software 
with the resultng system.  Yes, I am insane.  This is what's taking up all my 
spare hacking time these days...)

I'll replace glibc with uclibc (and the 2.4 headers with 2.6 headers) once 
I've finished with busybox.  (So far I've had to rewrite sed more or less 
from scratch, and revert to the non-busybox versions of sort, sh, awk, patch, 
ar, gzip, and gunzip.  But some of those are easy to fix, and the rest of 
busybox seems to be capable of being used as part of a development 
environment, even to the point of handling ./configure and make for the GNU 
tools they replace...)

Rob


