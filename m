Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751933AbWCVBgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWCVBgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 20:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWCVBgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 20:36:39 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:40523 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751933AbWCVBgi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 20:36:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfmJP5BBynz07BaHX9ZjBC2QZH51EYiuhn54LrK7Z/DL8qdDsa3jTFRA7RU/Q7fJSA4D7yu6Y705idozU/HF8/nhWFamUA1nCv4+Muw3xbTxezv3u/QE8syq6cbvzlWlKW3hzaACBaVto8ZdgLmK5JedQuiLmQBlrPvss+7uO4k=
Message-ID: <1458d9610603211736m1bdaacebn9bc958ad4763f3d1@mail.gmail.com>
Date: Wed, 22 Mar 2006 09:36:37 +0800
From: "Sumit Narayan" <talk2sumit@gmail.com>
To: "Anand SVR" <anand.svr@gmail.com>
Subject: Re: Accessing kernel information from a module
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <48a4d13c0603210809n681c3594mcdb41b7578a36dbd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <48a4d13c0603210302h3eb23f12v1bdf3c51c8f9b711@mail.gmail.com>
	 <1142939529.3077.57.camel@laptopd505.fenrus.org>
	 <48a4d13c0603210338s4cd1f120k80e1bbe6ac70669c@mail.gmail.com>
	 <48a4d13c0603210809n681c3594mcdb41b7578a36dbd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can use kernel probes (kprobe & jprobe) for accessing any
variables in the kernel. But ofcourse, this would be running-kernel
specific.

Link http://www.redhat.com/magazine/005mar05/features/kprobes/

Changing the kernel parameters is gonna be a very dangerous act,
unless you are sure of what you are doing.

-- Sumit



On 3/22/06, Anand SVR <anand.svr@gmail.com> wrote:
> Hi,
>
> I forgot to mention one more context. In the embedded environment where
> one is memory constrained, the lightweight and low memory foot-print
> module  I am referring to becomes relevant. In addition, since it is
> highly reliable, and remotely manageable as listed below I feel it is
> worth pursuing.
>
> Thanks for your time.
>
> Regards
> Anand
> On 3/21/06, Anand SVR <anand.svr@gmail.com> wrote:
> > Hi,
> >
> > The code is not yet ready :) I have a basic version that gives part of
> > memory statistics.
> >
> > Why I want to do it in kernel ? Following are the reasons.
> >
> > - Not all the information is available to the user space. There may be
> > situations where kernel developers, carrier grade server mainatainers,
> > and the like might want to access some internal run-time information
> > for debugging, fine-tuning and so on.
> >
> > - Keep it light weight, and least intrusive to the run-time behavior
> > of the system. No need for  tcp/udp socket communication.
> >
> > - There could be impending catastrophic situations where in kernel
> > cannot schedule user level processes, perhaps due to lack of memory or
> > whatever.
> >
> > - Ability for the remote node to change/control certain kernel
> > parameters by interacting with the module. This paves way for both
> > diagnosing and controlling kernel.
> >
> > Regards
> > Anand
> >
> > On 3/21/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Tue, 2006-03-21 at 16:32 +0530, Anand SVR wrote:
> > > > Hi,
> > > >
> > > > I am in the process of writing a module that collects kernel
> > > > information of various kernel subsytems and pass this on to a remote
> > > > monitoring/management node. The information could be statistical data
> > > > maintained in data structures of memory, process, network and so on.
> > > > Or it could be any kernel variables that are of interest.
> > >
> > > you forgot to attach your source code ;)
> > >
> > > > Is there a way of accessing proc information from the module ?
> > >
> > > eh why on earth is your code in the kernel then? Shouldn't your code be
> > > in userspace if you want to send such information to a remote system???
> > >
> > >
> > >
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
