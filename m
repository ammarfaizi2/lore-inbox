Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423645AbWJaVMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423645AbWJaVMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423646AbWJaVMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:12:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:26812 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423645AbWJaVMW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:12:22 -0500
To: Derek Fults <dfults@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow a hyphenated range in get_options, with cleanup
References: <1162328823.9542.434.camel@lnx-dfults.americas.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 31 Oct 2006 22:12:18 +0100
In-Reply-To: <1162328823.9542.434.camel@lnx-dfults.americas.sgi.com>
Message-ID: <p73d588kx59.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derek Fults <dfults@sgi.com> writes:

> This allows a hyphenated range of positive numbers in the string passed
> to command line helper function, get_options.    
> Currently the command line option "isolcpus=" takes as its argument a
> list of cpus.  
> Format: <cpu number>,...,<cpu number>
> This can get extremely long when isolating the majority of cpus on a
> large system.  Valid values of <cpu_number>  include all cpus, 0 to
> "number of CPUs in system - 1".

It would be better if you defined a separate function for this
instead of defining such a weird calling convention.

The common code with get_options could be factored out into a helper.

-Andi
