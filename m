Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVBXLnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVBXLnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVBXLnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:43:10 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:41148 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262231AbVBXLnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:43:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AYNUsabM/UAiI5AGsquXdwwdFPLmBrm1AgA59A6kRxRYaThL3B+C8JqkckiFcZEKmLHWtiIn3Uk2IHh6bVmJwAaRiXT74Q8Qm0zGtE4kgOM8ZCSeHsl2qxrMQpW8bnymaSyPA1F6LTlLH0tqnJJHTFSTiQIIGrMf8aM5in7I+OE=
Message-ID: <3f250c710502240343563c5cb0@mail.gmail.com>
Date: Thu, 24 Feb 2005 07:43:05 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] A new entry for /proc
Cc: hugh@veritas.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       rrebel@whenu.com, marcelo.tosatti@cyclades.com,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20050224010947.774628f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050106202339.4f9ba479.akpm@osdl.org>
	 <Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
	 <3f250c710502220513179b606a@mail.gmail.com>
	 <3f250c71050224003110e74704@mail.gmail.com>
	 <20050224010947.774628f3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

But can i use jiffies to measure this kind of performance??? AFAIK, if
it is more efficient, then it is faster, right? How can I know how
fast it is? Any idea?

BR,

Mauricio Lin.


On Thu, 24 Feb 2005 01:09:47 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Mauricio Lin <mauriciolin@gmail.com> wrote:
> >
> > You said that the old smaps version is not efficient because the way
> >  it access each pte.
> 
> Nick is talking about changing the kenrel so that it "refcounts pagetable
> pages".  I'm not sure why.
> 
> I assume that this means that each pte page's refcount will be incremented
> by one for each instantiated pte.  If so, then /proc/pid/smaps can become a
> lot more efficient.  Just add up the page refcounts on all the pte pages -
> no need to walk the ptes themselves.
> 
> Maybe?
>
