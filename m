Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbTFSP2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265805AbTFSP2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:28:54 -0400
Received: from pop.gmx.de ([213.165.64.20]:46017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265801AbTFSP2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:28:54 -0400
Message-Id: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 19 Jun 2003 17:47:12 +0200
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers
  needed
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andreas Boman <aboman@midgaard.us>
In-Reply-To: <200306200005.18005.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:

>Testers required. A version for -ck will be created soon.

That idea definitely needs some refinement.

Run test-starve.c, and try to login.  I'm not sure, but I don't think I've 
seen any task change more than one priority from what it started life 
at.  In test-starve's case, that's 16.  It's partner is at 16 as well, so 
it can't preempt (bad).  A dd if=/dev/zero of=/dev/null stays glued to 
21.  Repeated sh -c 'ps l $$'  bounces back and forth between 15 and 
21.  (maybe I should fly to Vegas.. when I try to login with test-starve 
running, I keep hitting 21:)

         -Mike 

