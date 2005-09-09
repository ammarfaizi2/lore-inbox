Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbVIIIri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVIIIri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVIIIri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:47:38 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:37130
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932552AbVIIIrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:47:37 -0400
Message-Id: <4321688A020000780002481E@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Sep 2005 10:48:42 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>, <discuss@x86-64.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [PATCH] x86-64 CFI annotation fixes and
	additions
References: <43207A6302000078000244F4@emea1-mh.id2.novell.com> <200509091040.11405.ak@suse.de>
In-Reply-To: <200509091040.11405.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The UNWIND_INFO part has still some problems - in particular it is
lying
>on all other architectures which don't check it yet. I made it
dependent
>on X86_64 right now.

I don't think so. First, the i386 patch also adds the same (as I
indicated), and second this controls also the
-fasynchronous-exception-tables compiler flag, which should be
generically available on all architectures (the i386 patch adds this to
the top level makefile, x86-64 is somewhat special in requiring the
-fno- form to be used in the opposite case, which is why this ends up in
the arch-specific makefile).

Jan
