Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSLQA4v>; Mon, 16 Dec 2002 19:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLQA4v>; Mon, 16 Dec 2002 19:56:51 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:1173 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262887AbSLQA4v>;
	Mon, 16 Dec 2002 19:56:51 -0500
Date: Tue, 17 Dec 2002 01:03:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217010321.GD31294@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20021209193649.GC10316@suse.de> <Pine.LNX.4.44.0212161639310.1623-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212161639310.1623-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 04:47:00PM -0800, Linus Torvalds wrote:

Cool, new toys 8-) I'll have a play with this tomorrow.
after a quick glance, one thing jumped out at me.

 > +static int __init sysenter_setup(void)
 > +{
 > +	if (!boot_cpu_has(X86_FEATURE_SEP))
 > +		return 0;
 > +
 > +	enable_sep_cpu(NULL);
 > +	smp_call_function(enable_sep_cpu, NULL, 1, 1);
 > +	return 0;

I'm sure I recall seeing errata on at least 1 CPU re sysenter.
If we do decide to go this route, we'll need to blacklist ones
with any really icky problems.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
