Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWCUQJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWCUQJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWCUQJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:09:34 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:42503 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750874AbWCUQJd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:09:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c4o52i0dz1qI5/4UZhtcOGxeQgyQ6/Nu0S5DdMigFiQw4mCSOdqYe7eRVrR6VF9XbccLBCmWYZpKsbGmNoQfXr2EMv3n2WY0wse7lbB4AVvO8qmGskU4yBb742tPhxAZL5GBgGNPe+VJxrtkLPJoUnlNAUSQ18pdFKo36uanNok=
Message-ID: <48a4d13c0603210809n681c3594mcdb41b7578a36dbd@mail.gmail.com>
Date: Tue, 21 Mar 2006 21:39:08 +0530
From: "Anand SVR" <anand.svr@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: Accessing kernel information from a module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <48a4d13c0603210338s4cd1f120k80e1bbe6ac70669c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
	 <1142939529.3077.57.camel@laptopd505.fenrus.org>
	 <48a4d13c0603210338s4cd1f120k80e1bbe6ac70669c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I forgot to mention one more context. In the embedded environment where
one is memory constrained, the lightweight and low memory foot-print
module  I am referring to becomes relevant. In addition, since it is
highly reliable, and remotely manageable as listed below I feel it is
worth pursuing.

Thanks for your time.

Regards
Anand
On 3/21/06, Anand SVR <anand.svr@gmail.com> wrote:
> Hi,
>
> The code is not yet ready :) I have a basic version that gives part of
> memory statistics.
>
> Why I want to do it in kernel ? Following are the reasons.
>
> - Not all the information is available to the user space. There may be
> situations where kernel developers, carrier grade server mainatainers,
> and the like might want to access some internal run-time information
> for debugging, fine-tuning and so on.
>
> - Keep it light weight, and least intrusive to the run-time behavior
> of the system. No need for  tcp/udp socket communication.
>
> - There could be impending catastrophic situations where in kernel
> cannot schedule user level processes, perhaps due to lack of memory or
> whatever.
>
> - Ability for the remote node to change/control certain kernel
> parameters by interacting with the module. This paves way for both
> diagnosing and controlling kernel.
>
> Regards
> Anand
>
> On 3/21/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > On Tue, 2006-03-21 at 16:32 +0530, Anand SVR wrote:
> > > Hi,
> > >
> > > I am in the process of writing a module that collects kernel
> > > information of various kernel subsytems and pass this on to a remote
> > > monitoring/management node. The information could be statistical data
> > > maintained in data structures of memory, process, network and so on.
> > > Or it could be any kernel variables that are of interest.
> >
> > you forgot to attach your source code ;)
> >
> > > Is there a way of accessing proc information from the module ?
> >
> > eh why on earth is your code in the kernel then? Shouldn't your code be
> > in userspace if you want to send such information to a remote system???
> >
> >
> >
>
