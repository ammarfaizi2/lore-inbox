Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270820AbTHAQaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 12:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbTHAQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 12:30:23 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:62604 "EHLO
	ophelia.hpce.nec.com") by vger.kernel.org with ESMTP
	id S270820AbTHAQaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 12:30:22 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Date: Fri, 1 Aug 2003 18:30:07 +0200
User-Agent: KMail/1.5.1
Cc: Andi Kleen <ak@muc.de>
References: <200307280548.53976.efocht@gmx.net> <200307312345.36368.efocht@hpce.nec.com> <380280000.1059697615@flay>
In-Reply-To: <380280000.1059697615@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011830.07280.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 02:26, Martin J. Bligh wrote:
> np - was easy to fix up ;-) I did run some benchmarks on it ...
> low end SDET seemed highly variable, but otherwise looked OK.
> If I have only 4 tasks running on a 16x (4x4), what's the rate
> limit on the idle cpus trying to steal now?

the rate is 3ms, that's a bit too fast, maybe. And the busy rate is
200ms (instead of 400). I made some experiments with 2 CPUs per node
and 1 ms seems to be definitely too fast. I'll tune the formula a
bit...

Regards,
Erich


