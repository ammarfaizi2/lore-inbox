Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWHDAzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWHDAzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWHDAzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:55:22 -0400
Received: from ns.suse.de ([195.135.220.2]:33217 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932583AbWHDAzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:55:21 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: don't taint UP K7's running SMP kernels. II
References: <20060803183224.GA10797@redhat.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Aug 2006 02:55:20 +0200
In-Reply-To: <20060803183224.GA10797@redhat.com>
Message-ID: <p737j1pz5dz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> We have a test that looks for invalid pairings of certain athlon/durons
> that weren't designed for SMP, and taint accordingly (with 'S') if we find
> such a configuration.  However, this test shouldn't fire if there's only
> a single CPU present. It's perfectly valid for an SMP kernel to boot on UP
> hardware for example.

Actually the test should be for num_possible_cpus() I fixed this.

-Andi
