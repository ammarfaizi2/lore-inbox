Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUINLkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUINLkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269302AbUINLiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:38:11 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:55246 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269299AbUINLfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:35:22 -0400
Date: Tue, 14 Sep 2004 13:34:19 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Ray Bryant <raybry@sgi.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [profile] amortize atomic hit count increments
Message-ID: <20040914113419.GH4180@dualathlon.random>
References: <20040913015003.5406abae.akpm@osdl.org> <20040914044748.GZ9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914044748.GZ9106@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 09:47:48PM -0700, William Lee Irwin III wrote:
> timer interrupt, usually at boot. The following patch attempts to 
> amortize the atomic operations done on the profile buffer to address 
> this stability concern. This patch has nothing to do with performance;

isn't it *much* simpler and much more efficient to just have a per-cpu
idle function? I seriously doubt you'll get simultaneous collisions on
anything but the 'halt' instruction in the idle function.
