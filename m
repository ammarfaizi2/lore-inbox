Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbUDPTk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDPTk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:40:56 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:34198 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262514AbUDPTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:40:50 -0400
Date: Fri, 16 Apr 2004 12:40:48 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040416194048.GA23015@lucon.org>
References: <20040416170915.GA20260@lucon.org> <408020E2.9060900@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408020E2.9060900@domdv.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 08:07:30PM +0200, Andreas Steinmetz wrote:
> H. J. Lu wrote:
> >is set with executable stack. Is there a third option that a process
> >starts with non-executable stack and can change the stack permission
> >later?
> >
> 
> Well, in my opinion your request is equivalent to "keep all these cute 
> buffer overflows forever". Take any protected app, LD_PRELOAD or drop in 
> a bad/malicious library and your're done for good. Not really a good idea.

The current scheme doesn't work too well. Linker doesn't combine
PT_GNU_STACK from DSO:

http://sources.redhat.com/ml/binutils/2004-04/msg00341.html

for a reason. It expects the dynamic linker to do that at the run-time,
which kernel won't allow. I am looking for a reasonable solution.


H.J.
