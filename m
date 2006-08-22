Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWHVOjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWHVOjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 10:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWHVOjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 10:39:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26273 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932275AbWHVOjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 10:39:17 -0400
Date: Tue, 22 Aug 2006 20:08:31 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Rik van Riel <riel@redhat.com>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Matt Helsley <matthltc@us.ibm.com>, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 2/7] UBC: core (structures, API)
Message-ID: <20060822143831.GA12458@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <44E33893.6020700@sw.ru> <44E33BB6.3050504@sw.ru> <1155866328.2510.247.camel@stark> <44E5A637.1020407@sw.ru> <1155955116.2510.445.camel@stark> <44E992B9.8080908@sw.ru> <20060822122329.GA7125@in.ibm.com> <44EAFCBA.10400@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EAFCBA.10400@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 04:46:50PM +0400, Kirill Korotaev wrote:
> Srivatsa Vaddagiri wrote:
> > On Mon, Aug 21, 2006 at 03:02:17PM +0400, Kirill Korotaev wrote:
> > 
> >>>Except that you eventually have to lock ub0. Seems that the cache line
> >>>for that spinlock could bounce quite a bit in such a hot path.
> >>
> >>do you mean by ub0 host system ub which we call ub0
> >>or you mean a top ub?
> > 
> > 
> > If this were used for pure resource management purpose (w/o containers)
> > then the top ub would be ub0 right? "How bad would the contention on the
> > ub0->lock be then" is I guess Matt's question.
> Probably we still misunderstand here each other.
> top ub can be any UB. it's children do account resources
> to the whole chain of UBs to the top parent.
> 
> i.e. ub0 is not a tree root.

Hmm ..if I understand you correctly, there is no one single root of the
ubc tree? In other words, there can be several roots (each representing
a distinct group of processes)? CKRM has one single root afaik, under
which multiple resource/task groups are derived.

-- 
Regards,
vatsa
