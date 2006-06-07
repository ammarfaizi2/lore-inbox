Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWFGRpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFGRpy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750857AbWFGRpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:45:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53940 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750761AbWFGRpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:45:53 -0400
Date: Wed, 7 Jun 2006 13:50:18 -0400
From: Don Zickus <dzickus@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
Message-ID: <20060607175018.GU2839@redhat.com>
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <4485AC1F.9050001@goop.org> <20060607024938.GG11696@redhat.com> <448707DA.9090801@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448707DA.9090801@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:07:38AM -0700, Jeremy Fitzhardinge wrote:
> Don Zickus wrote:
> >Makes the start/stop paths of nmi watchdog more robust to handle the
> >suspend/resume cases more gracefully.
> >  
> This solves the original symptom, but I'm seeing something else now.  
> After the second resume, there's a noticable pause after it brings cpu 1 
> online.  After the third resume it's a longer pause, and after the 4th 
> it just hangs there.  The system is up enough to respond to sysreq, but 
> nothing in usermode seems to be actually running.  I'll try and get a 
> better understanding of what I'm seeing later today.
> 
>    J

Can you do me a quick favor and 'cat /proc/interrupts |grep NMI' before
each of your suspends.  I want to double check a piece of code.  Your
bugzilla postings showed your system starting with no nmi watchdog running
but after the resume the watchdog started running on cpu1.  I am hoping I
fixed that issue too.

Thanks.

Cheers,
Don

