Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSBHXyS>; Fri, 8 Feb 2002 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291664AbSBHXyI>; Fri, 8 Feb 2002 18:54:08 -0500
Received: from zero.tech9.net ([209.61.188.187]:30478 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287874AbSBHXyC>;
	Fri, 8 Feb 2002 18:54:02 -0500
Subject: Re: [PATCH] Read-Copy Update 2.5.4-pre2
From: Robert Love <rml@tech9.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0202081847020.30304-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 08 Feb 2002 18:54:02 -0500
Message-Id: <1013212443.806.196.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-08 at 18:51, Mark Hahn wrote:

> yes, but have you evaluated whether it's noticably better than
> other forms of locking?  for instance, couldn't your dcache example
> simply use BR locks?

Good point.

One of the things with implicit locking schemes like RCU is that the
performance hit merely shifts.  Reading the data may no longer have any
overhead, but the hit is taken elsewhere.  One most be careful in
benchmarking RCU locking.

	Robert Love

