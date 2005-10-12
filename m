Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVJLPjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVJLPjF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbVJLPjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:39:04 -0400
Received: from [81.2.110.250] ([81.2.110.250]:44458 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751465AbVJLPjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:39:00 -0400
Subject: Re: using segmentation in the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Brian Gerst <bgerst@didntduck.org>,
       "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
In-Reply-To: <1129107936.3082.34.camel@laptopd505.fenrus.org>
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org>
	 <434C1F8E.6080405@gmail.com>
	 <1129107936.3082.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Oct 2005 17:07:11 +0100
Message-Id: <1129133231.7966.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-10-12 at 11:05 +0200, Arjan van de Ven wrote:
> >  separate modules so that they 
> > will not affect kernel and more...
> 
> and I don't believe this one yota. THe only way to do this is to run
> modules in ring 1, at which point you are in deep shit anyway.

Not neccessarily. Its how Xen works on x86-32 for example. It keeps
itself protected from the entire Linux instance by using segmentation on
32bit processors (not 64bit however as x86-64 has no segments in 64bit)

Doing that without major work on the kernel itself would be hard, and
you'd need to isolate out things like page table updates and verify them
whenever modules wanted to touch such stuff

Alan

