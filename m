Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWFFXiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWFFXiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWFFXiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:38:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751360AbWFFXiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:38:00 -0400
Date: Tue, 6 Jun 2006 19:42:32 -0400
From: Don Zickus <dzickus@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060606234232.GD11696@redhat.com>
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com> <200606061618.15415.ak@suse.de> <20060606214553.GB11696@redhat.com> <20060606151507.613edaad.akpm@osdl.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org> <44860F7B.2040105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44860F7B.2040105@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 04:27:55PM -0700, Jeremy Fitzhardinge wrote:
> Andrew Morton wrote:
> >All the above applies to suspend-to-disk.  I don't know if suspend-to-RAM
> >shuts down the APs.
> >  
> 
> I'm using suspend-to-mem and it looks like its unplugging/replugging all 
> the CPUs.
> 
> The part of the question I don't quite understand is why this is 
> considered per-CPU state?  Surely NMI-watchdog is a system-wide thing?  
> Or does this also tie into other uses of the performance registers which 
> may be set per-CPU?
> 
>    J

The nmi watchdog is enable/disabled on a per-cpu basis.  The fact that a
single switch turns all of them on/off is just convienance.  Adding in
code to turn them on/off on a per-cpu basis just requires a simple user
interface.  It has been talked about before to deal with NUMA systems. 

Cheers,
Don

