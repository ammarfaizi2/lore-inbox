Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289850AbSAPHkH>; Wed, 16 Jan 2002 02:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289773AbSAPHj5>; Wed, 16 Jan 2002 02:39:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:49885 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S289757AbSAPHjr>; Wed, 16 Jan 2002 02:39:47 -0500
Date: Wed, 16 Jan 2002 08:38:56 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Craig Christophel <merlin@transgeek.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: likely/unlikely
In-Reply-To: <20020116113143.C99F8B581@smtp.transgeek.com>
Message-ID: <Pine.NEB.4.44.0201160832000.17456-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Craig Christophel wrote:

> > likely/unlikely set the branch prediction values to 99% or 1%
>
>
> 	So all of the BUG() routines in the kernel would benifit greatly from this.

In the 2.5 kernels this is done when you use the BUG_ON macro that is
defined as follows:

#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)


BTW: Note that likely/unlikely doesn't has any effect for most of us
     because __builtin_expect is only available in gcc >= 2.96.


> Craig.

cu
Adrian


