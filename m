Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265608AbUFDFEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265608AbUFDFEs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbUFDFEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:04:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30350 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265609AbUFDFEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:04:45 -0400
Date: Thu, 3 Jun 2004 22:01:07 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603220107.7590cbcc.davem@redhat.com>
In-Reply-To: <20040603220224.73cd8d44.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<20040603170725.4b3f8b34.akpm@osdl.org>
	<20040603194755.667e584b.pj@sgi.com>
	<20040603195409.11d4aec2.davem@redhat.com>
	<20040603220224.73cd8d44.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 22:02:24 -0700
Paul Jackson <pj@sgi.com> wrote:

> The generic only is quite a bit simpler - it has some 26 fewer kernel
> source files, and it saves sparc64 some 1144 bytes of kernel text space,
> as measured by Andrew.

I bet if you do a sparc32 build, you'll get larger text size
and more leaf functions will need stack frames.

> I really don't want to go 'back' to the fancy version.  If a particular
> architecture has specific additional needs, I'm certainly open to
> hearing the justifications, tradeoffs and suggestions for ways to meet
> those needs.

Another thing is that only newer gcc's are good at changing structure
accesses such that they are optimized as aggregates when possible.

You're the one doing the work, so it's up to you. :-)
