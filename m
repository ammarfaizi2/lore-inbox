Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265813AbUFYMqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265813AbUFYMqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbUFYMqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:46:43 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:45181 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265813AbUFYMql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:46:41 -0400
Date: Fri, 25 Jun 2004 07:46:28 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040625083130.GA26557@infradead.org>
Message-ID: <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
 <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com>
 <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
 <20040625083130.GA26557@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please kill the ifdef completely.  As long as LANANA hasn't responded you
> should only use the dyanic nimor, and once it's accepted there's no point
> in using the dynamico ne anymore.  Also I'd sugges grabbing a whole dyanmic
> major instead of using a miscdevice so the code both cases is more similar.

We don't really have an option here.  None of the distros I know of will
currently work with dynamic minors for the console device.  If we only use
dynamic minors, our driver will simply not work with most of the
distributions.

I don't want a driver that will break our console - I want one that will
make it work better.  Dynamic minors, at least today, will just break us.

Plus, as I said before, LANANA's web page states they don't accept
submissions for the 2.6 kernel.  What are we to do?

Thanks.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
