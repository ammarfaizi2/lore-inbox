Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbSK1RwH>; Thu, 28 Nov 2002 12:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266601AbSK1RwH>; Thu, 28 Nov 2002 12:52:07 -0500
Received: from president.dataforce.net ([195.42.160.21]:44406 "HELO
	president.dataforce.net") by vger.kernel.org with SMTP
	id <S266578AbSK1RwF>; Thu, 28 Nov 2002 12:52:05 -0500
Date: Thu, 28 Nov 2002 21:00:41 +0300
From: Solar Designer <solar@openwall.com>
To: Paul Szabo <psz@maths.usyd.edu.au>
Cc: bugtraq@securityfocus.com, cliph@isec.pl, linux-kernel@vger.kernel.org,
       security@debian.org, security@isec.pl, vulnwatch@vulnwatch.org
Subject: Re: d_path() truncating excessive long path name vulnerability
Message-ID: <20021128180041.GA13008@openwall.com>
References: <200211270204.gAR244k330285@milan.maths.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211270204.gAR244k330285@milan.maths.usyd.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 01:04:04PM +1100, Paul Szabo wrote:
> Back in March 2002, Wojciech Purczynski <cliph@isec.pl> wrote (original
> article at http://online.securityfocus.com/archive/1/264117 ):
> 
> > Name:		Linux kernel
> > Version:	up to 2.2.20 and 2.4.18
> > ...
> > In case of excessively long path names d_path kernel internal function
> > returns truncated trailing components of a path name instead of an error
> > value. As this function is called by getcwd(2) system call and
> > do_proc_readlink() function, false information may be returned to
> > user-space processes.
> 
> The problem is still present in Debian 2.4.19 kernel. I have not tried 2.5,
> but see nothing relevant in the Changelogs at http://www.kernel.org/ .

FWIW, I've included a workaround for this (covering the getcwd(2) case
only, not other uses of d_path() by the kernel or modules) in 2.2.21-ow1
patch and it went into 2.2.22 release in September.

This kind of proves the need for double-checking newer kernel branches
(2.4.x and 2.5.x currently) for fixes going into what many consider
stable kernels.

-- 
/sd
