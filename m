Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280660AbRKJNrj>; Sat, 10 Nov 2001 08:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280663AbRKJNra>; Sat, 10 Nov 2001 08:47:30 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:22536 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id <S280660AbRKJNrR>; Sat, 10 Nov 2001 08:47:17 -0500
Date: Sat, 10 Nov 2001 13:44:34 +0000
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Adding KERN_INFO to some printks #2
Message-ID: <20011110134434.A94031@compsoc.man.ac.uk>
In-Reply-To: <01110913474600.02130@nemo> <1005321383.1209.8.camel@phantasy> <01110923204702.00807@nemo> <1005342348.808.18.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005342348.808.18.camel@phantasy>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:45:48PM -0500, Robert Love wrote:

> I went over the patch and found a few things...
> 
> printk(KERN_INFO "No local APIC present or hardware disabled\n");
> 
>  I'd make this a KERN_WARNING.  Consider the case where I compile my own
> kernel and I add APIC support.  If the driver is failing to find my APIC
> then either (a) my BIOS is broken or (b) I should remove the driver. 
> Either way I would want to know.

This isn't what's happening - check apic.c. It is re-enabled if possible,
or a local APIC really doesn't exist. Either way I don't see the point
in a warning.

regards
john

-- 
"I know I believe in nothing but it is my nothing"
	- Manic Street Preachers
