Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284854AbRLMS7U>; Thu, 13 Dec 2001 13:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLMS7L>; Thu, 13 Dec 2001 13:59:11 -0500
Received: from stine.vestdata.no ([195.204.68.10]:21408 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S284854AbRLMS7A>; Thu, 13 Dec 2001 13:59:00 -0500
Date: Thu, 13 Dec 2001 19:58:57 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org
Subject: Re: User-manageable sub-ids proposals
Message-ID: <20011213195856.A30952@vestdata.no>
In-Reply-To: <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com> <20011212204333.A4017@pimlott.ne.mediaone.net> <3C1873A2.1060702@namesys.com> <20011213113616.B6547@pern.dea.icai.upco.es> <20011213143752.A17124@vestdata.no> <20011213170629.A16572@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011213170629.A16572@pern.dea.icai.upco.es>; from romano@dea.icai.upco.es on Thu, Dec 13, 2001 at 05:06:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 05:06:29PM +0100, Romano Giannetti wrote:
> > 2 do we want the "slave" to be able to write the users files
> 
> Generally no, but you can create a dir where the slave uid can create file
> (think to a java applet that need temporary files, etc...) 

I think generally temporary files should go to /tmp and not the home
directory, but yes, there may be reasons to write to specific files in
the home directory as well.

> > This should also be possible to implement with minimal impact. All you
> > need is a new systemcall to allocate a uid for the slave. This means you
> > need to reserve some uids for this purpose, but with 32bit uids......
> 
> Yes, but then the slave process is very much _very_ limited. It could need
> to read/map dynamic libraries, for example; with my approach the slave uid
> processes are processes that have a full-level citizenship and that can do
> anything a process can do, but under a different name than the user. Root
> uses "nobody" to this extent sometime; my proposal is to extend this to
> every (unprivileged) user in a safe way. Then, you can create a chrooted
> environment for the new process and tailor the level of access it has
> depending on the needs.

Why would the slave not be able to read/map dynamic libraries in my
sceeme? Such files should be readable by everyone, so I don't see the
problem?

With ACL support I don't see this beeing limited at all. The process can
be given any rights you desire before changing it's effective userid.


-- 
Ragnar Kjørstad
Big Storage
