Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTKRIvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 03:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTKRIvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 03:51:00 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21685
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262410AbTKRIum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 03:50:42 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: shoxx@web.de, linux-kernel@vger.kernel.org
Subject: Re: problem with suspend to disk on linux2.6-t9
Date: Tue, 18 Nov 2003 02:45:08 -0600
User-Agent: KMail/1.5
References: <200311172327.24418.shoxx@web.de>
In-Reply-To: <200311172327.24418.shoxx@web.de>
Cc: Patrick Mochel <mochel@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311180245.08960.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 November 2003 16:27, dodger wrote:
> hi
> i am using linux2.6-t9 and i am trying to use suspend to disk
> when doing a
> < echo -n "disk" > /sys/power/state >
>
> it is suspending real fine.
> but it is not resuming at all.
> i tried to boot up normally and with resume=/dev/hdb5 ( swap partition )
> but nothing happens...
>
> it just boots up normally...
> i have set /dev/hdb5 as DEFAULT RESUME PARTITION during kernel config...
>
> any ideas?
> thanks

Hmmm...  Looking at my dmesg from the last boot up (which was a clean boot and 
not a resume from suspend), it doesn't seem like the suspend code prints out 
anything when it's checking for a resume image.  (On the other hand, the APIC 
code prints out three screenfulls of useless trivia.  Fun...)

Patrick: is there some kind of debug switch we can set to make it more 
verbose?  (I don't see one in the code.  I'm going to be sprinkling in 
printks myself as soon as my rebuild sans preempt finishes...)

Rob

