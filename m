Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUIWXtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUIWXtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIWXpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:45:16 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39384 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267552AbUIWXnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:43:12 -0400
Date: Thu, 23 Sep 2004 16:41:39 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: simon.derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
Message-Id: <20040923164139.506d65d3.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409231238350.11694@server.home>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
	<20040911010808.2b283c9a.pj@sgi.com>
	<Pine.LNX.4.58.0409231238350.11694@server.home>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Simon's 2nd patch provides a translation that we need at SGI for perfmon
> support within a cpuset. Without the virtualization some
> means in user space needs to exist to translate a virtual CPU number
> into a physical CPU number.

In my opinion, user space is exactly the right place for this translation.

Those inside SGI can see more detail of this in SGI Incident 903969.

But the jist of the matter is simple.  Just as we (SGI) did with
cpumemsets and perfmon on 2.4 kernels, so should we do with cpusets and
perfmon on 2.6 kernels.  And that is to perform this translation in
perfmon code.  Is it only SGI's dplace that requires the cpuset-relative
numbering?

The kernel-user boundary should stick to a single, system-wide, numbering
of CPUs.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
