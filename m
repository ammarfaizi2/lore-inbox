Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWEOUq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEOUq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWEOUq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:46:59 -0400
Received: from over.ny.us.ibm.com ([32.97.182.150]:50083 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S1751508AbWEOUq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:46:58 -0400
Subject: Re: [PATCH] x86 NUMA panic compile error
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, apw@shadowen.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605152037.54242.ak@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	 <200605152013.53728.ak@suse.de> <20060515113439.457f5809.akpm@osdl.org>
	 <200605152037.54242.ak@suse.de>
Content-Type: text/plain
Date: Mon, 15 May 2006 12:05:01 -0700
Message-Id: <1147719901.6623.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 20:37 +0200, Andi Kleen wrote:
> My arguments for remove:
> - The code is very hackish - it was written before the proper ACPI
> infrastructure is in place - and NUMA on 32bit in general needs a lot
> of hacks because of the limited ZONE_NORMAL.
> - NUMA on 32bit is kind of broken by design.
> - It isn't used much.
> - It breaks often
> - It tends to not work on Opterons and hits the users who try it
> there.

I think you are right: there are very few end users running with
CONFIG_NUMA on normal x86.  But, there is a disproportionately large
number of developers who do it.  There are quite a few IBM (and maybe
more via OSDL) developers who's only access to real NUMA hardware is x86
NUMAQs and Summit machines.  When somebody says "foo is broken on NUMA",
I go right to an x86 box.

Anyway, I'd like to think that we've contributed enough to the generic
NUMA code to have earned our keep and allow our little x86 NUMA "hacks"
to remain.  x86 is a legacy architecture now anyway, right? ;)

-- Dave

