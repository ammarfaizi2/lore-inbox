Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319624AbSH3RS1>; Fri, 30 Aug 2002 13:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319626AbSH3RS1>; Fri, 30 Aug 2002 13:18:27 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:25240 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319624AbSH3RS0>;
	Fri, 30 Aug 2002 13:18:26 -0400
Date: Fri, 30 Aug 2002 10:19:15 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG+FIX] 2.4 buggercache sucks
Message-ID: <30940000.1030727954@flay>
In-Reply-To: <200208301121.06437.roy@karlsbakk.net>
References: <200208291000.46618.roy@karlsbakk.net> <318656043.1030603363@[10.10.2.3]> <200208301121.06437.roy@karlsbakk.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Was your workload doing lots of reads, or lots of writes? Or both?
> 
> I was downloading large files @ ~ 4Mbps from 20-50 clients - filesize ~3GB
> the box has 1GB memory minus (no highmem) - so - 900 megs. After some time it 
> starts swapping and it OOMs. Same happens with several userspace httpd's

Mmmm .... not quite sure which way round to read that. Presumably the box
that was the server fell over, and the clients are fine? So the workload that's
causing problems is doing predominantly reads? If so, I suggest you tear down
Andrew's patch to read side only, and submit that ... I get the feeling that would
be acceptable, and would solve your problem.

M.

