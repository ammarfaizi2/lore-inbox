Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbRFJCE4>; Sat, 9 Jun 2001 22:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263043AbRFJCEq>; Sat, 9 Jun 2001 22:04:46 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:12164 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263034AbRFJCEb>;
	Sat, 9 Jun 2001 22:04:31 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106100204.TAA18733@csl.Stanford.EDU>
Subject: Re: checker suggestion
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sat, 9 Jun 2001 19:04:28 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
In-Reply-To: <200106090811.f598BBB505292@saturn.cs.uml.edu> from "Albert D. Cahalan" at Jun 09, 2001 04:11:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Struct padding is a problem. Really, there shouldn't be any
> implicit padding. This causes:
> 
> 1. security leaks when such structs are copied to userspace
>    (the implicit padding is uninitialized, and so may contain
>    a chunk of somebody's private key or password)
> 
> 2. bloat, when struct members could be reordered to eliminate
>    the need for padding

(1) is a great point.   One of the first extensions in our first system
automatically reordered structure fields to minimize padding (your second
point), but we'd totally missed the security point.

Thanks!
