Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265615AbUFDFYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbUFDFYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 01:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbUFDFYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 01:24:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265615AbUFDFYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 01:24:44 -0400
Date: Thu, 3 Jun 2004 22:22:09 -0700
From: "David S. Miller" <davem@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@muc.de,
       ashok.raj@intel.com, hch@infradead.org, jbarnes@sgi.com,
       joe.korty@ccur.com, manfred@colorfullife.com, colpatch@us.ibm.com,
       mikpe@csd.uu.se, Simon.Derr@bull.net, wli@holomorphy.com
Subject: Re: [PATCH] cpumask 5/10 rewrite cpumask.h - single bitmap based
 implementation
Message-Id: <20040603222209.27166d0f.davem@redhat.com>
In-Reply-To: <20040603221854.25d80f5a.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
	<20040603101010.4b15734a.pj@sgi.com>
	<1086313667.29381.897.camel@bach>
	<40BFD839.7060101@yahoo.com.au>
	<20040603221854.25d80f5a.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 22:18:54 -0700
Paul Jackson <pj@sgi.com> wrote:

> The "ideal" solution, in my view, would be to have someone with arch
> specific experience in each affected arch code these uses of cpus_addr()
> out, then remove cpus_addr() entirely.
> 
> Perhaps I should comment the cpus_addr() definition as 'deprecated'?

I would suggest just making the build fail for these cases.
You could do this by simply doing something like:

#error Assumes cpumask_t is integral type

at the suspect spots.
