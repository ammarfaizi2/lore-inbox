Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbWCVGJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWCVGJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCVGJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:09:45 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:16728 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750800AbWCVGJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:09:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VRqkPlP3fMmUzy5mcFPBEjkNOqRR6zBbpOkzK7UOPAHz0P1cS5UKT2rSxLvBYZmntnrHTYVmWfzddWs5CwWHqtjj/iwzECzRakITaqJW1QgtEIL+O8MJcZhDN6DOCuMyJYQSm6wCHIB7IDpCCilt6BikI7ecLxqXSafa5Pu2fW0=
Message-ID: <48a4d13c0603212209jbed8ae7s889518bb64dd1679@mail.gmail.com>
Date: Wed, 22 Mar 2006 11:39:43 +0530
From: "Anand SVR" <anand.svr@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Accessing kernel information from a module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1142958503.3077.98.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
	 <1142939529.3077.57.camel@laptopd505.fenrus.org>
	 <48a4d13c0603210338s4cd1f120k80e1bbe6ac70669c@mail.gmail.com>
	 <48a4d13c0603210809n681c3594mcdb41b7578a36dbd@mail.gmail.com>
	 <1142958503.3077.98.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The module is going to be "memory less" in the sense that it only fetches data
of interest that is already maintained  in the kernel, forms a message
and send it. In terms of memory, may be few skbs might be consumed for
sending the data across for remote monitoring. This is the main
objective of the project.

Yes, for controlling the kernel parameters one may have to add logic,
but I would
presume that is not going to be too complex and big.

Regards
Anand

On 3/21/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-03-21 at 21:39 +0530, Anand SVR wrote:
> > Hi,
> >
> > I forgot to mention one more context. In the embedded environment where
> > one is memory constrained, the lightweight and low memory foot-print
> > module  I am referring to becomes relevant.
>
> that is a questionable argument; kernel memory is non-pagable while
> userspace memory is, so for me the tradeoff isn't immediately a clear
> win for doing it in the kernel..
>
>
