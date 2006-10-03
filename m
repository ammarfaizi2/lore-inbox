Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965443AbWJCH2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965443AbWJCH2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 03:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965451AbWJCH2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 03:28:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:58284 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965443AbWJCH2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 03:28:18 -0400
Subject: Re: [PATCH 5/6] From: Andrew Morton <akpm@osdl.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20061003002014.321f68b6.akpm@osdl.org>
References: <20061003010842.438670755@goop.org>
	 <20061003010933.392428107@goop.org>
	 <17697.58794.113796.925995@cargo.ozlabs.ibm.com>
	 <20061002213347.8229b6fc.akpm@osdl.org>
	 <17697.62198.476469.265990@cargo.ozlabs.ibm.com>
	 <20061002225053.46be0324.akpm@osdl.org>
	 <17698.2424.528747.211313@cargo.ozlabs.ibm.com>
	 <20061003002014.321f68b6.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 17:25:51 +1000
Message-Id: <1159860351.5482.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> yup, that fixed it.  xmon apparently doesn't know where fbcon's output
> cursor is, but the characters are now readable.

The low level text engine used by xmon (and my some early console/debug
stuff on powerpc as well) really doesn't have any link to fbcon... doing
that would be hard and ugly and take the risk of making it fragile,
which isn't what we want to do... usually, when you fall into xmon, you
don't care about your console cursor :) (In fact, that stuff can even
blast on top of X if the later has the UseFBDev option).

Ben.


