Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUJFHYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUJFHYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 03:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJFHYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 03:24:24 -0400
Received: from solidcore.com ([66.201.45.194]:62437 "EHLO solidcore.com")
	by vger.kernel.org with ESMTP id S268648AbUJFHYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 03:24:21 -0400
Subject: Re: KVM -> jumping mouse... still no solution?
From: Rajendra P Mishra <rpm@solidcore.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4163845C.9020900@nodivisions.com>
References: <4163845C.9020900@nodivisions.com>
Content-Type: text/plain
Message-Id: <1097047425.3745.92.camel@scs13>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 06 Oct 2004 12:53:46 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One quick solution I know of is to restart the gpm daemon,
(/etc/init.d/gpm  restart) that resets the mouse settings.
But this is not the correct way, there should be some way
where the driver automatically detects and resets the mouse.

bye,
-rpm
On Wed, 2004-10-06 at 11:06, Anthony DiSante wrote:
> Hello,
> 
> I first got a KVM switch around the time of kernel 2.2.something, and when 
> using it to switch to a Linux system, the mouse "freaks out."  It's fine if 
> you don't move it, but if you move it N/E/NE it's really slow and jerky, and 
> if you move it S/W/SW even a hair, it slams down to the SW corner of the 
> screen and acts like you hit all the mouse's buttons 50 times simultaneously.
> 
> When switching to an MS Windows system (any version from 98 on up; haven't 
> tried anything earlier) the mouse works fine, it just pauses for maybe a 
> second at first, during which I assume it's doing some kind of PS/2 reset.
> 
> It used to be that switching out of X-windows with Ctrl-Alt-F[1-6] and then 
> back to VT7 would reset the mouse, but that hasn't worked in about a year 
> for me.  I was also able to run a little script to send a few specific chars 
> to the mouse device that seemed to reset it... that too no longer works. 
> The only thing that works now is unplugging the mouse from the KVM and then 
> back in.
> 
> The other day I came across this (kerneltrap.org/node/view/2199): "Use 
> psmouse.proto=bare on the kernel command line, or proto=bare on the
> psmouse module command line."  But that makes the mouse's scroll-wheel not 
> work.  (And this problem doesn't exist with some of the mouse drivers, but 
> it does with IMPS/2, which is the only one I've ever been able to get the 
> scroll wheel working with.)
> 
> Is there really no solution to this problem?  If Microsoft can figure it 
> out, I'm sure someone in the Linux community can... not that I'm 
> volunteering, of course...
> 
> -Anthony DiSante
> http://nodivisions.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

