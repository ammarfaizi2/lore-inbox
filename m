Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291952AbSBATxl>; Fri, 1 Feb 2002 14:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291961AbSBATx0>; Fri, 1 Feb 2002 14:53:26 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:14303 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291952AbSBATw1>; Fri, 1 Feb 2002 14:52:27 -0500
Date: Fri, 1 Feb 2002 13:52:25 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201135225.D8599@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201133833.B8599@asooo.flowerfire.com> <1012593032.1095.7.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1012593032.1095.7.camel@phantasy>; from rml@tech9.net on Fri, Feb 01, 2002 at 02:50:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 02:50:31PM -0500, Robert Love wrote:
| What is the output of `/proc/sys/kernel/random/entropy_avail' when
| programs are stalled?  Is it actually 0?

Yep, and it never raises above that -- it doesn't jump around even after
a month.

| Can you see if any programs are perhaps draining entropy in the
| background?  See what has /dev/[u]random open ... note even /dev/urandom
| uses entropy, its the same as /dev/random, except it doesn't care when
| the entropy estimate is 0.

I've scanned /proc to verify that all PIDs do not have an FD open to
/dev/random.  This was my first guess when this started -- some
developer was draining entropy in a while(1) loop.  I believe I went so
far as to go to runlevel 1 with nothing but sh and kernel threads.

That may not be comprehensive, so I'm open to other diagnostic tips.
And yes, /dev/urandom does continue to work, as expected.

Thanks!
-- 
Ken.
brownfld@irridia.com

| 	Robert Love
