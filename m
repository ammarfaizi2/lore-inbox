Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVAUWGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVAUWGx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVAUWFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:05:55 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:14602 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262556AbVAUWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:01:24 -0500
Date: Fri, 21 Jan 2005 23:09:50 +0100
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, binary search result
Message-ID: <20050121220950.GA28786@hh.idb.hist.no>
References: <fa.jfkohta.1il0fq0@ifi.uio.no> <fa.hh8592m.qji2ie@ifi.uio.no> <csrn9o$b83$1@pD9F87519.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <csrn9o$b83$1@pD9F87519.dip0.t-ipconnect.de>
User-Agent: Mutt/1.5.6+20040907i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 09:05:12PM +0100, Andreas Hartmann wrote:
> Hello Helge,
> 
> Helge Hafting schrieb:
> > On Sun, Jan 16, 2005 at 10:41:23PM +1100, Dave Airlie wrote:
> >> > 
> >> > I'm fine with adding this code, but we still don't know if this is the
> >> > cause of his problem. The debug output can determine if this really is
> >> > the source of the problem or if it is somewhere else.
> >> > 
> >> 
> >> I actually doubt it is this stuff.. my guess is that it is something
> >> nasty like ACPI breaking int10 for X or something like that... it
> >> seems a lot more subtle than the usually things that break when we
> >> mess with the DRM :-)
> 
> Which glibc do you use? I have problems with glibc 2.3.4, kernel 2.4.x and
> X / Xorg while executing the int10-code of X. glibc 2.3.3 works fine for
> me. But I could find another posting, which describes, that there are even
> problems with glibc 2.3.3 and kernel 2.4.x.
> 
> It's new for me, that there could be problems with kernelversions of 2.6, too.
> 
> Therefore, it would be really interessting to know, which glibc version
> you are using.
> 
I use glibc 2.3.2 from debian testing (or unstable).  
This is not the problem though, because a reboot into 2.6.8.1 makes
X work without crashing.  The crash only happens with 2.6.9-rc2
or later kernels.  

So the only way glibc could be the culprit, is if the newer kernel
exports some new interface that this glibc manages to mess up.  Still,
even a buggy glibc shouldn't hang the kernel anyway.  Such issues
could crash (all) user apps, but shouldn't prevent the machine from
responding to sysrq sequences.

Helge Hafting
