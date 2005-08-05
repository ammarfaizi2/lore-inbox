Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbVHEQmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbVHEQmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbVHEQmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:42:25 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48597 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263082AbVHEQlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:41:31 -0400
Date: Fri, 5 Aug 2005 12:34:16 -0500
From: serue@us.ibm.com
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Stacker - single-use static slots
Message-ID: <20050805173416.GA8991@sergelap.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com> <Lynx.SEL.4.62.0507271535150.1844@thoron.boston.redhat.com> <20050803164516.GB13691@serge.austin.ibm.com> <Lynx.SEL.4.62.0508051154150.8981@thoron.boston.redhat.com> <20050805172720.GA8870@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805172720.GA8870@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting serue@us.ibm.com (serue@us.ibm.com):
> Quoting James Morris (jmorris@redhat.com):
> > On Wed, 3 Aug 2005 serue@us.ibm.com wrote:
> > 
> > > The attached patch implements your idea on top of my previous patchset.
> > > Following is performance data on a 16-way ppc.  dbench and tbench were
> > > run 50 times, kernbench and reaim 10 times each;  results are mean +/-
> > > 95% confidence half-interval.  The 'static slot' kernel had a single
> > > static slot for selinux, plus the (unused in this case) shared struct
> > > hlist_head security.
> > 
> > Can you also compare with no stacker at all (i.e. just SELinux with caps 
> > as secondary module) ?
> 
> Will do.
> 
> I'll try to get a full set of numbers by next week, comparing:
> 
> 	no stacker
> 	"original" stacker
> 	stacker with one shared slot
> 	stacker with two shared slots

Obviously, I meant to say stacker with one static slot (and one shared
slot), and stacker with two static slots (and one shared slot)  :)

thanks,
-serge
