Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291926AbSBATpB>; Fri, 1 Feb 2002 14:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291934AbSBATo5>; Fri, 1 Feb 2002 14:44:57 -0500
Received: from zero.tech9.net ([209.61.188.187]:7187 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S291926AbSBAToN>;
	Fri, 1 Feb 2002 14:44:13 -0500
Subject: Re: Continuing /dev/random problems with 2.4
From: Robert Love <rml@tech9.net>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020201133833.B8599@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com>
	<1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> 
	<20020201133833.B8599@asooo.flowerfire.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Feb 2002 14:50:31 -0500
Message-Id: <1012593032.1095.7.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-01 at 14:38, Ken Brownfield wrote:

> Of course, in my case deleting the /dev/random character node still
> doesn't allow entropy to drain in (after at least a month) so I suspect
> the kernel's entropy generation would be sufficient if it didn't
> artificially stall or drain from within the kernel.

Agreed, I suspect you do indeed have a problem.

What is the output of `/proc/sys/kernel/random/entropy_avail' when
programs are stalled?  Is it actually 0?

Can you see if any programs are perhaps draining entropy in the
background?  See what has /dev/[u]random open ... note even /dev/urandom
uses entropy, its the same as /dev/random, except it doesn't care when
the entropy estimate is 0.

	Robert Love

