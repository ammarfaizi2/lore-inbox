Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264794AbSIWCU5>; Sun, 22 Sep 2002 22:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSIWCU4>; Sun, 22 Sep 2002 22:20:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42513 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264794AbSIWCU4>; Sun, 22 Sep 2002 22:20:56 -0400
Date: Sun, 22 Sep 2002 19:27:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Michel Eyckmans (MCE)" <mce@pi.be>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.38 
In-Reply-To: <200209230019.g8N0JmvC003642@jebril.pi.be>
Message-ID: <Pine.LNX.4.44.0209221924210.1208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Sep 2002, Michel Eyckmans (MCE) wrote:
> 
> The boot time lock up, that I have indeed encountered intermittently ever 
> since switching to 2.5.3{01}, may indeed be gone, but the one where just 
> moving my mouse around locks things up in a matter of seconds hasn't. 

That may just be due to the new mouse driver and/or input layer, which 
went in some weeks ago. What kind of mouse (and if it is a PS/2 mouse, can 
you get a loaner USB mouse to test with, for example?)

> Someone recently reported having similar problems and fixing them by 
> disabling MTRR, but this cannot be the entire story since I never had it 
> enabled in the first place. No wonder, on a dual P5 machine...

There was a separate MTRR atomicity problem that would cause extreme 
slowdowns on SMP with MTRR enabled when X was started, because the MTRR 
code would have re-entrancy problems and potentially leave the caches 
disabled. That should have been fixed in 2.5.36.

		Linus

