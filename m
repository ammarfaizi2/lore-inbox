Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUG1UOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUG1UOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUG1UOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 16:14:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:49044 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263100AbUG1UOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 16:14:01 -0400
Subject: Re: Use of __pa() with CONFIG_NONLINEAR
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <35960000.1091044039@flay>
References: <1090965630.15847.575.camel@nighthawk>
	 <20040728181645.GA13758@w-mikek2.beaverton.ibm.com>
	 <35960000.1091044039@flay>
Content-Type: text/plain
Message-Id: <1091045615.2871.364.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 13:13:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 12:47, Martin J. Bligh wrote:
> Can someone explain the necessity to create the new address space? We don't
> need it with the current holes between nodes, and from my discssions with
> Andy, I'm now unconvinced it's necessary.

Actually, the new address space is quite separated from what I'm
proposing here.  I'd prefer to discuss that part when we have an
implementation surrounding it.  I can explain it now if you'd like, but
it's going to be a bit harder with no code.  

The reason we need boot-time __{p,v}a() macros is really quite separate
from the new (logical) address space.  These new macros are just so we
can assume flat addressing during boot or compile-time, before any
nonlinear structures are set up.

-- Dave

