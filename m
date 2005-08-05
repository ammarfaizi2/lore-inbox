Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262911AbVHEP4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbVHEP4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVHEP4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:56:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262955AbVHEP4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:56:05 -0400
Date: Fri, 5 Aug 2005 11:55:28 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
In-Reply-To: <20050803164516.GB13691@serge.austin.ibm.com>
Message-ID: <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com>
References: <20050727181732.GA22483@serge.austin.ibm.com>
 <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
 <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com>
 <20050803164516.GB13691@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2005 serue@us.ibm.com wrote:

> The attached patch implements your idea on top of my previous patchset.
> Following is performance data on a 16-way ppc.  dbench and tbench were
> run 50 times, kernbench and reaim 10 times each;  results are mean +/-
> 95% confidence half-interval.  The 'static slot' kernel had a single
> static slot for selinux, plus the (unused in this case) shared struct
> hlist_head security.

Can you also compare with no stacker at all (i.e. just SELinux with caps 
as secondary module) ?


- James
-- 
James Morris
<jmorris@redhat.com>

