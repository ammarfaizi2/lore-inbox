Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317059AbSGXWIh>; Wed, 24 Jul 2002 18:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGXWIh>; Wed, 24 Jul 2002 18:08:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6640 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317059AbSGXWIg>; Wed, 24 Jul 2002 18:08:36 -0400
Subject: Re: Linux-2.5.28
From: Robert Love <rml@tech9.net>
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1027547856.7700.70.camel@plars.austin.ibm.com>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
	<1027547187.7700.67.camel@plars.austin.ibm.com> 
	<1027547856.7700.70.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Jul 2002 15:11:47 -0700
Message-Id: <1027548707.927.1350.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 14:57, Paul Larson wrote:
> On Wed, 2002-07-24 at 16:46, Paul Larson wrote:
> > Error building 2.5.28:
> 
> Forgot to mention this is an SMP box.  Without CONFIG_SMP it works fine.

This is known... there is a handful of drivers still using the old
global IRQ methods that need a spring cleaning.

On UP, we "cheat" and define the global methods to the local ones and
everything is happy.  On SMP you are out of luck until the code if
fixed.

	Robert Love

