Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUDARtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDARtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:49:12 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29828
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263005AbUDARtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:49:11 -0500
Date: Thu, 1 Apr 2004 19:49:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, kenneth.w.chen@intel.com,
       Chris Wright <chrisw@osdl.org>
Subject: Re: disable-cap-mlock
Message-ID: <20040401174910.GS18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401164825.GD791@holomorphy.com> <20040401165952.GM18585@dualathlon.random> <20040401171625.GE791@holomorphy.com> <1080841071.25431.155.camel@moss-spartans.epoch.ncsc.mil> <20040401174405.GG791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401174405.GG791@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 09:44:05AM -0800, William Lee Irwin III wrote:
> I'm aware it does some very unintelligent things to the security model,
> e.g. anyone with fs-level access to these things can basically escalate
> their capabilities to "everything". Maybe some kind of big fat warning
> is in order.

a similar issue happens with the disable-cap-mlock, but it gives only
mlock to the guy with fs-level fsuid = 0 access, so the security
implications are greatly lower, no way to do anything really bad with
just access to mlock (DoS is the very worst scenario, and it's not very
different from swapoff -a anyways, or again not very different from
filling the swap enterely as far as security is concerned).
