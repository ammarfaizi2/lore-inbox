Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTLQQBX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLQQBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:01:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:41610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264446AbTLQQBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:01:21 -0500
Date: Wed, 17 Dec 2003 08:01:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zaitsev <peter@mysql.com>
cc: Mike Fedyk <mfedyk@matchmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
In-Reply-To: <1071657159.2155.76.camel@abyss.local>
Message-ID: <Pine.LNX.4.58.0312170758220.8541@home.osdl.org>
References: <200312151434.54886.adasi@kernel.pl>  <20031216040156.GJ12726@pegasys.ws>
 <3FDF1C03.2020509@aitel.hist.no>  <Pine.LNX.4.58.0312160825570.1599@home.osdl.org>
  <20031216205853.GC1402@matchmail.com>  <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
 <1071657159.2155.76.camel@abyss.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Dec 2003, Peter Zaitsev wrote:
> 
> I'm pretty curious about this argument,
> 
> Practically as RAID5 uses XOR for checksum computation you do not have
> to read the whole stripe to recompute the checksum.

Ahh, good point. Ignore my argument - large stripes should work well. Mea 
culpa, I forgot how simple the parity thing is, and that it is "local".

However, since seeking will be limited by the checksum drive anyway (for 
writing), the advantages of large stripes in trying to keep the disks 
independent aren't as one-sided. 

		Linus
