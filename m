Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269831AbRHDIPj>; Sat, 4 Aug 2001 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269833AbRHDIPa>; Sat, 4 Aug 2001 04:15:30 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52233 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269836AbRHDIPW>; Sat, 4 Aug 2001 04:15:22 -0400
Date: Sat, 4 Aug 2001 05:43:30 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
Message-ID: <20010804054330.G16516@emma1.emma.line.org>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <0108032026140F.01827@starship> <Pine.GSO.4.21.0108031423280.3272-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031423280.3272-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2001, Alexander Viro wrote:

> Sigh... You need i_sem for fsync(). Moreover, there is no warranty that
> set of objects you sync has _anything_ to path by the time when you start
> syncing the second one. Application has information about the use of
> parts of tree it's interested in. Kernel doesn't. Notice that all this
> wankage was full of "oh, but MTA doesn't care for symlinks", "oh, but MTA
> doesn't deal with parents renamed", ad nausea. You know what it means?

I know a few MTAs, but none of them use symlinks, they always use hard
links (if at all).

MTAs don't rename parent directories.

> Folks, putting policy into the kernel is Wrong(tm). And that's precisely
> what you are advocating here.

Is putting options with a user-space interface (mount option, file
system option such as chattr) wrong as well? Is making fsync() more
compatible wrong?

-- 
Matthias Andree
