Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293390AbSCJX4u>; Sun, 10 Mar 2002 18:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293393AbSCJX4l>; Sun, 10 Mar 2002 18:56:41 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:13073 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293390AbSCJX4V>; Sun, 10 Mar 2002 18:56:21 -0500
Date: Mon, 11 Mar 2002 00:56:19 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Andreas Jaeger <aj@suse.de>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] syscall interface for cpu affinity
Message-ID: <20020311005619.A1481@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	Andreas Jaeger <aj@suse.de>, Robert Love <rml@tech9.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1015784104.1261.8.camel@phantasy> <u8zo1g9nf8.fsf@gromit.moeb> <1015793618.928.17.camel@phantasy> <u8bsdw9lvd.fsf@gromit.moeb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <u8bsdw9lvd.fsf@gromit.moeb>; from aj@suse.de on Sun, Mar 10, 2002 at 10:03:02PM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 10:03:02PM +0100, Andreas Jaeger wrote:
> >
> > Note you can use the syscall interface with existing programs, too. 
> > Just write a program to take in a pid and mask and call
> > sched_set_affinity.
> What I need at the moment is a wrapper - and you can do it two ways:
> 
> $ run_with_affinity 1 program arguments...
> $ (cat 1 > /proc/self/affinity; program arguments...)
> 
> The second one is much easier coded ;-)

$ (set_affinity 1; program arguments...)

set_affinity just calls sched_set_affinity(getppid()), and everything
is fine (and even shorter to type) :-)

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
