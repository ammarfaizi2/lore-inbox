Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbTI3N2S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbTI3N2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:28:18 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:39730 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261460AbTI3N1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:27:50 -0400
Date: Tue, 30 Sep 2003 14:27:29 +0100
From: Dave Jones <davej@redhat.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
Message-ID: <20030930132729.GB23333@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <20030929125629.GA1746@averell> <bla6lf$3ul$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bla6lf$3ul$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 09:02:39PM +0000, bill davidsen wrote:
 > In article <20030929125629.GA1746@averell>, Andi Kleen  <ak@muc.de> wrote:
 > 
 > | It removes the previous dumb in kernel workaround for this and shrinks the 
 > | kernel by >10k.
 > | 
 > | Small behaviour change is that a SIGBUS fault for a *_user access will
 > | cause an EFAULT now, no SIGBUS.
 > | 
 > | This version addresses all criticism that I got for previous versions.
 > | 
 > | - Only checks on AMD K7+ CPUs. 
 > | - Computes linear address for VM86 mode or code segments
 > | with non zero base.
 > | - Some cleanup
 > | - No pointer comparisons
 > | - More comments
 > 
 > I have to try this on a P4 and K7, but WRT "Only checks on AMD K7+ CPUs"
 > I hope you meant "only generates code if AMD CPU is target" and not that
 > the code size penalty is still there for CPUs which don't need it.

NO NO NO NO NO.
This *has* to be there on a P4 kernel too, as we can now boot those on a K7 too.
The 'code size penalty' you talk about is in the region of a few hundred
bytes. Much less than a page. There are far more obvious bloat candidates.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
