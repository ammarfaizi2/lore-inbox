Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVCAOd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVCAOd0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 09:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVCAOdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 09:33:25 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:38852 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261922AbVCAOdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 09:33:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CHlBrg5PviIExFkIUHJVE2oB5TpUafAcMYkJt8zUQPSkVnmzTRDxdBOqxAeDjjRI68SD4EumT7ZTCpndJQ0o2IDlA3QAoWMF7ZLeD+DHVTxW3Pbie+He0yjAO54yTFtdbBQDLH1a2zwPJXOuOI1YrC3hb8TTQ2LVDCdg0G+a3t0=
Message-ID: <3f250c71050301063228f3507e@mail.gmail.com>
Date: Tue, 1 Mar 2005 10:32:45 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Albert Cahalan <albert@users.sf.net>
Subject: Re: [PATCH] A new entry for /proc
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <1109271379.5125.180.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109271379.5125.180.camel@cube>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
> The most important thing about a /proc file format is that it has
> a documented means of being extended in the future. Without such
> documentation, it is impossible to write a reliable parser.
> 
> The "Name: value" stuff is rather slow. Right now procps (ps, top, etc.)
> is using a perfect hash function to parse the /proc/*/status files.
> ("man gperf") This is just plain gross, but needed for decent performance.

So, change the output format is important, right?
 
> Extending the /proc/*/maps file might be possible. It is commonly used
> by debuggers I think, so you'd better at least verify that gdb is OK.
> The procps "pmap" tool uses it too. To satisfy the procps parser:
> 
> a. no more than 31 flags
> b. no '/' prior to the filename
> c. nothing after the filename
> d. no new fields inserted prior to the inode number
> 

Yes, probably smaps is more feasible for tracking environment. Do you
know any public kernel (I mean kernel version for tracking and
debugging)  where can I post the smaps PATCH in order to be included?

BR,

Mauricio Lin.
