Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUEVQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUEVQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUEVQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:58:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1189 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261668AbUEVQ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:58:37 -0400
Date: Thu, 20 May 2004 15:49:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rob Landley <rob@landley.net>
Cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040520134955.GA5215@openzaurus.ucw.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <200405121139.58742.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405121139.58742.rob@landley.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Catching up on some really old mail, I thought I'd ask:
> 
> For years now I've wanted to use a sendfile variant to tell the system to 
> connect two filehandles from userspace.  Not just web servers want to 
> marshall data from one filehandle into another, things like netcat want to do 
> it between a pipe and a network connection, and I've wrote a couple of data 
> dispatcher daemons that wanted to do it between two network connections.
> 
> Unfortunately, sendfile didn't work generically when I tried it (back under 
> 2.4).  Would this infrastructure be a step in the right direction to 
> eliminate gratuitous poll loops (where nobody but me EVER seems to get the 
> "shutdown just one half of the connection" thing right.  My netcat can handle 
> "echo 'GET /' | netcat www.slashdot.org 80".  The standard netcat can't.  
> Yes, I plan to fix the one in busybox eventually...)
> 

Ugh. Yes, some syscalls like that were proposed... but to
make programming easier, you'd need asynchronous
sendfile to help you with programming, right?

				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

