Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRFNMRq>; Thu, 14 Jun 2001 08:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRFNMR1>; Thu, 14 Jun 2001 08:17:27 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:64969 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S262262AbRFNMRS>; Thu, 14 Jun 2001 08:17:18 -0400
Message-Id: <200106141214.f5ECEaL3022945@typhaon.pacific.net.au>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Download process for a "split kernel" (was: obsolete code must die) 
In-Reply-To: Your message of "Thu, 14 Jun 2001 08:07:11 -0400."
             <200106141207.f5EC7CA4030080@pincoya.inf.utfsm.cl> 
In-Reply-To: <200106141207.f5EC7CA4030080@pincoya.inf.utfsm.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 22:14:35 +1000
From: David Luyer <david_luyer@pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  (I wrote)
> > This might actually make sense - a kernel composed of multiple versioned
> > segments.  A tool which works out dependencies of the options being selected,
> > downloads the required parts if the latest versions of those parts are not
> > already downloaded, and then builds the kernel (or could even build during
> > the download, as soon as the build dependencies for each block of the kernel
> > are satisfied, if you want to be fancy...).
> 
> Please do look at the archives to find out just why this idea is floated
> each 3 to 4 months and then shot down, and why.

Well, I'm actually looking at the 2nd idea I mentioned in my e-mail -- a very 
small "kernel package" which has a config script, a list of config options and
the files they depend on and an appropriately tagged CVS tree which can then be
used for a compressed checkout of a version to do a build.  (Or maybe something
more bandwidth-friendly than CVS for the initial checkout.)

Maybe I'll find the spare time to do it, maybe I won't, either way I won't post
any more on the subject until I have something tangible (so far I've just 
done the 'easy bit': written a quick shell script which imported 2.4.x into a
tagged CVS tree; the 'hard bit', to write a script to analyse each kernel rev
and determine which files are used by which config options and mix that in
together with the minimal install for a 'make menuconfig' will take somewhat
longer).

David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF


