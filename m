Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbTHZDMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbTHZDMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:12:08 -0400
Received: from saturn.galaxy.net ([198.144.230.8]:21437 "HELO galaxy.net")
	by vger.kernel.org with SMTP id S262413AbTHZDMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:12:05 -0400
Date: Mon, 25 Aug 2003 22:46:11 -0400 (EDT)
From: "John K. Walton" <walton@mrnutty.com>
To: bf-committers@blender.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [Bf-committers] [RFC] Re: Blender profiling-1 O16.2int
In-Reply-To: <200308261454.03069.Christopher.Maddock.1@uni.massey.ac.nz>
Message-ID: <Pine.LNX.4.21.0308252244020.7487-100000@mrnutty.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Kester Maddock wrote:

> 
> On Sun, Aug 17, 2003 at 11:36:42PM +1000, Con Kolivas wrote:
> > Now normally, blender should just sleep and wait till X comes
> > alive again before it does anything. However here it shows clearly that 
> > it is spinning madly looking for something from X, and poor X can't do 
> > anything. This is the busy on wait I've described.
> 
> > Second, any applications that exhibit this should be fixed since it is a bug. 
> 
> Say if blender is polling the mouse in the view rotate loop?  (If so, you 
> should be able to just hold down the middle mouse to starve, without moving 
> the mouse.)

yes i've mentioned this in the past. holding the middle mouse or right
mouse button _without_doing_anything_ eats up cpu time. it is clearly
a waste of cpu time. nobody responded.

> Is this really a bug in the application?  Blender is interactive while rotating 
> the view.  More CPU means more frames per second which gives the user a
> better experience.  The CPU usage will drop down when the user releases the
> middle mouse button.
> 
> (OK, in this specific case blender could update the screen on mouse move 
> events, but what about the general case eg a 3d game, where the screen
> is updated by eg monster ai?)
> 
> And how do you fix it?  Would sleep(0) in these loops do, or do you need to
> select(...) on X?
> 
> CC me please on replys.
> 
> Thanks,
> 
> Kester Maddock.
> ^ sends occaisional patches to blender.
> 
> 
> _______________________________________________
> Bf-committers mailing list
> Bf-committers@blender.org
> http://www.blender.org/mailman/listinfo/bf-committers
> 

