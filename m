Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWI2I5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWI2I5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWI2I5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:57:47 -0400
Received: from colin.muc.de ([193.149.48.1]:28680 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030429AbWI2I5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:57:47 -0400
Date: 29 Sep 2006 10:57:45 +0200
Date: Fri, 29 Sep 2006 10:57:45 +0200
From: Andi Kleen <ak@muc.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
Message-ID: <20060929085745.GA41098@muc.de>
References: <20060928225444.439520197@goop.org>> <20060928225452.229936605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928225452.229936605@goop.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some architectures (powerpc) implement WARN using the same mechanism;
> if the illegal instruction was the result of a WARN, then report_bug()
> returns 1; otherwise it returns 0.

In theory we could do that on x86 too (and skipping the instruction), 
the only problem 
is that the only guaranteed to fault opcode is ud2 :/. Ok maybe we could
reserve some int XXX vector.

% gid WARN_ON | grep -v arch | wc -l
299

-Andi
