Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262930AbVAKWx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbVAKWx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVAKWu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:50:27 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:54245 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262936AbVAKWt3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:49:29 -0500
Message-Id: <200501112248.j0BMmh9t006949@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: Chris Wright <chrisw@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Tue, 11 Jan 2005 13:28:23 PST."
             <20050111212823.GX2940@waste.org> 
Date: Tue, 11 Jan 2005 17:48:43 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.197.39.54] at Tue, 11 Jan 2005 16:49:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But I'm also still not convinced this policy can't be most flexibly
>handled by a setuid helper together with the mlock rlimit.

This has been explained several times already.

When you run a JACK client, the user should not be required to use a
different command sequence depending on whether or not JACK is running
with RT scheduling or not. That's almost more arcane than the current
situation and is a step backwards from even 2.4, where we use
capabilities to allow JACK itself to pass on the ability to use RT
scheduling and memlock to its clients.

--p
