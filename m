Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316269AbSEVRYJ>; Wed, 22 May 2002 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316293AbSEVRYI>; Wed, 22 May 2002 13:24:08 -0400
Received: from smtp.eol.ca ([205.189.152.19]:242 "HELO smtp.eol.ca")
	by vger.kernel.org with SMTP id <S316269AbSEVRYH>;
	Wed, 22 May 2002 13:24:07 -0400
Date: Wed, 22 May 2002 13:24:04 -0400
From: William Park <opengeometry@yahoo.ca>
To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
Subject: Re: Safety of -j N when building kernels?
Message-ID: <20020522132404.A449@node1.opengeometry.ca>
Mail-Followup-To: "Linux kernel mailing list (lkml)" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020522165320.GC18059@lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 10:53:20AM -0600, Eric Weigle wrote:
> Ok, stupid question of the moment-
> 
> I always read about the kernel compilation benchmarks people run on the
> ultra-snazzy new machines, but do people actually run the kernels thus
> generated?
> 
> I have visions of a process being backgrounded to generate some files, and
> not completing before the one of the old files gets linked into the kernel
> (because not all files were listed as dependencies, for example).
> 
> So are the kernel's current Makefiles really SMP safe -- can one really
> run multiple jobs when building Linux kernels? Any horror stories, or am
> I just paranoid?

I usually do
    make menuconfig
    make -j3 dep
    make -j3 bzImage modules	
    make -j3 bzlilo modules_install
where I separate the compile and install part.  But, this depends on what
you are compiling.  I usually have problem with Compaq and Hamradio stuffs,
so I have them commented out.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8-CPU Cluster, Hosting, NAS, Linux, LaTeX, python, vim, mutt, tin
