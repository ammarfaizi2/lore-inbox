Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbTHZC5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 22:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTHZC5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 22:57:22 -0400
Received: from mta204-rme.xtra.co.nz ([210.86.15.147]:38810 "EHLO
	mta204-rme.xtra.co.nz") by vger.kernel.org with ESMTP
	id S262448AbTHZC5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 22:57:21 -0400
From: Kester Maddock <Christopher.Maddock.1@uni.massey.ac.nz>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Re: Blender profiling-1 O16.2int
Date: Tue, 26 Aug 2003 14:54:03 +1200
User-Agent: KMail/1.5
Cc: bf-committers@blender.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261454.03069.Christopher.Maddock.1@uni.massey.ac.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Aug 17, 2003 at 11:36:42PM +1000, Con Kolivas wrote:
> Now normally, blender should just sleep and wait till X comes
> alive again before it does anything. However here it shows clearly that 
> it is spinning madly looking for something from X, and poor X can't do 
> anything. This is the busy on wait I've described.

> Second, any applications that exhibit this should be fixed since it is a bug. 

Say if blender is polling the mouse in the view rotate loop?  (If so, you 
should be able to just hold down the middle mouse to starve, without moving 
the mouse.)

Is this really a bug in the application?  Blender is interactive while rotating 
the view.  More CPU means more frames per second which gives the user a
better experience.  The CPU usage will drop down when the user releases the
middle mouse button.

(OK, in this specific case blender could update the screen on mouse move 
events, but what about the general case eg a 3d game, where the screen
is updated by eg monster ai?)

And how do you fix it?  Would sleep(0) in these loops do, or do you need to
select(...) on X?

CC me please on replys.

Thanks,

Kester Maddock.
^ sends occaisional patches to blender.


