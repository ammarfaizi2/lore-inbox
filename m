Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVLCN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVLCN4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 08:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVLCN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 08:56:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751259AbVLCN4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 08:56:08 -0500
Date: Sat, 3 Dec 2005 14:56:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051203135608.GJ31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel development model is pretty good for people who 
always want to use or offer their costumers the maximum amount of the 
latest bugs^Wfeatures without having to resort on additional patches for 
them.

Problems of the current development model from a user's point of view 
are:
- many regressions in every new release
- kernel updates often require updates for the kernel-related userspace 
  (e.g. for udev or the pcmcia tools switch)

One problem following from this is that people continue to use older 
kernels with known security holes because the amount of work for kernel 
upgrades is too high.

These problems follow from the development model.

The latest stable kernel series without these problems is 2.4, but 2.4 
is becoming more and more obsolete and might e.g. lack driver support 
for some recent hardware you want to use.

Since Andrew and Linus do AFAIK not plan to change the development 
model, what about the following for getting a stable kernel series 
without leaving the current development model:


Kernel 2.6.16 will be the base for a stable series.

After 2.6.16, there will be a 2.6.16.y series with the usual stable 
rules.

After the release of 2.6.17, this 2.6.16.y series will be continued with 
more relaxed rules similar to the rules in kernel 2.4 since the release 
of kernel 2.6.0 (e.g. driver updates will be allowed).


Q:
What is the target audience for this 2.6.16 series?

A:
The target audience are users still using 2.4 (or who'd still use kernel 
2.4 if they weren't forced to upgrade to 2.6 for some reason) who want a 
stable kernel series including security fixes but excluding many 
regressions.
It might also be interesting for distributions that prefer stability 
over always using the latest stuff.


Q:
Does this proposal imply anything for the development between 2.6.15 and 
2.6.16?

A:
In theory not.
In practice, it would be a big advantage if some of the bigger 
changes that might go into 2.6.16 would be postponed to 2.6.17.


Q:
Why not start with the more relaxed rules before the release of 2.6.17?

A:
After 2.6.16.y following the usual stable rules, the kernel should be 
relatively stable and well-tested giving the best possible basis for a 
long-living series.


Q:
How long should this 2.6.16 series be maintained?

A:
Time will tell, but if people use it I'd expect 2 or 3 years.


Q:
Stable API/ABI for external modules?

A:
No.


Q:
Who will maintain this branch?

A:
I could do it, but if someone more experienced wants to do it that would 
be even better.
