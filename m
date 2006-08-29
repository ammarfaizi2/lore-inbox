Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWH2BAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWH2BAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWH2BAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:00:25 -0400
Received: from ozlabs.org ([203.10.76.45]:11712 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750769AbWH2BAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:00:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17651.37281.67926.208085@cargo.ozlabs.ibm.com>
Date: Tue, 29 Aug 2006 11:00:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: "Dong Feng" <middle.fengdong@gmail.com>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <200608280923.24677.ak@suse.de>
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
	<17650.13915.413019.784343@cargo.ozlabs.ibm.com>
	<200608280923.24677.ak@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> > That's fair enough, but I would be opposed to 
> > making semaphores bigger 
> 
> If the code was out of lined bigger wouldn't make much difference

I was referring to the data size not the code size.

> That would leave the fast path, but does it help that much there
> to have a more complicated implementation?

The implementation of the fast path is basically atomic_inc/dec.
Nothing more complicated.

Paul.
