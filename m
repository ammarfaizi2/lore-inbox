Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270577AbRIGBD7>; Thu, 6 Sep 2001 21:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270401AbRIGBDt>; Thu, 6 Sep 2001 21:03:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15635 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270438AbRIGBDl>; Thu, 6 Sep 2001 21:03:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: psusi@cfl.rr.com, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] (Updated) Preemptible Kernel
Date: Fri, 7 Sep 2001 03:10:56 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <999813729.2039.9.camel@phantasy> <200109070046.f870kEM06465@smtp-server2.tampabay.rr.com>
In-Reply-To: <200109070046.f870kEM06465@smtp-server2.tampabay.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907010351Z16175-26183+75@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 6, 2001 10:39 pm, Phillip Susi wrote:
> ... what happens if 
> say, the kernel called from user space is holding a lock, and gets preempted? 

The thread will eventually get rescheduled and release the lock.

>  Is there a mechanism to disable preemption while holding locks or at other 
> resources that need to be freed before another task is run?

IIRC spinlocks inhibit scheduling, the simplest way to handle that.

--
Daniel
