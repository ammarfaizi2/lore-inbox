Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752113AbWFLQLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbWFLQLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbWFLQLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:11:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:45779 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752113AbWFLQLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:11:15 -0400
Subject: Re: [SPARSEMEM] confusing uses of SPARSEM_EXTREME (try #2)
From: Dave Hansen <haveblue@us.ibm.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: apw@shadowen.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <448D1117.8010407@innova-card.com>
References: <448D1117.8010407@innova-card.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 09:10:03 -0700
Message-Id: <1150128603.13644.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 09:00 +0200, Franck Bui-Huu wrote:
> Is it me or the use of CONFIG_SPARSEMEM_EXTREME is really confusing in
> mm/sparce.c ? Shouldn't we use CONFIG_SPARSEMEM_STATIC instead like
> the following patch suggests ? 

I'll take positive config options over negative ones any day.  I find it
easier to read things that say what they *are* rather than what they are
*not*.

In any case, STATIC is really there as an override for architectures to
say, "I know what I am doing, I use gcc 3.4 and above, or, I don't want
to use bootmem".  Extreme is really there to say, "I want two-level
lookups because my memory is extremely sparse."

Make sense?

-- Dave

