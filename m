Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbTIPNbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTIPNbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:31:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50125 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261908AbTIPNbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:31:35 -0400
Date: Tue, 16 Sep 2003 14:30:19 +0100
From: Dave Jones <davej@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: richard.brunner@amd.com, alan@lxorguk.ukuu.org.uk, davidsen@tmr.com,
       zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030916133019.GA1039@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jamie Lokier <jamie@shareable.org>, richard.brunner@amd.com,
	alan@lxorguk.ukuu.org.uk, davidsen@tmr.com, zwane@linuxpower.ca,
	linux-kernel@vger.kernel.org
References: <99F2150714F93F448942F9A9F112634C0638B1DE@txexmtae.amd.com> <20030916114636.GF26576@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916114636.GF26576@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 12:46:36PM +0100, Jamie Lokier wrote:

 > > The user space problem worries me more, because the expectation
 > > is that if CPUID says the program can use perfetch, it could
 > > and should regardless of what the kernel decided to do here.
 > 
 > If the workaround isn't compiled in, "prefetch" should be removed from
 > /proc/cpuinfo on the buggy chips.

prefetch isn't a cpuid feature flag. The only way you could do
what you suggest is by removing '3dnow' or 'sse', which cripples
things more than necessary.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
