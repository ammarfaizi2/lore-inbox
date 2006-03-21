Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWCULkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWCULkK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWCULkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:40:10 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:61851 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030351AbWCULkI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:40:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mg0i42jyQu7ePRQtfPgpN0+7hys0LIYYYVoMkGdc7GbUIa/nvduHZT9gq0Lpi/Fs1WGgMXRgLXs2Lg3L1LqZDTA0ZEyJLzrs07I7pjSQ77RtRoxpMEIQYrcHm9LqP1Vt8/2UVKK9pCaKx9wHwWhewolbP5ySFD71MrSUnavqKw0=
Message-ID: <48a4d13c0603210340n16707aafved1874e43a99ae44@mail.gmail.com>
Date: Tue, 21 Mar 2006 17:10:07 +0530
From: "Anand SVR" <anand.svr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Accessing kernel information from a module
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

---------- Forwarded message ----------
From: Anand SVR <anand.svr@gmail.com>
Date: Mar 21, 2006 5:08 PM
Subject: Re: Accessing kernel information from a module
To: Arjan van de Ven <arjan@infradead.org>


Hi,

The code is not yet ready :) I have a basic version that gives part of
memory statistics.

Why I want to do it in kernel ? Following are the reasons.

- Not all the information is available to the user space. There may be
situations where kernel developers, carrier grade server mainatainers,
and the like might want to access some internal run-time information
for debugging, fine-tuning and so on.

- Keep it light weight, and least intrusive to the run-time behavior
of the system. No need for  tcp/udp socket communication.

- There could be impending catastrophic situations where in kernel
cannot schedule user level processes, perhaps due to lack of memory or
whatever.

- Ability for the remote node to change/control certain kernel
parameters by interacting with the module. This paves way for both
diagnosing and controlling kernel.

Regards
Anand

On 3/21/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-03-21 at 16:32 +0530, Anand SVR wrote:
> > Hi,
> >
> > I am in the process of writing a module that collects kernel
> > information of various kernel subsytems and pass this on to a remote
> > monitoring/management node. The information could be statistical data
> > maintained in data structures of memory, process, network and so on.
> > Or it could be any kernel variables that are of interest.
>
> you forgot to attach your source code ;)
>
> > Is there a way of accessing proc information from the module ?
>
> eh why on earth is your code in the kernel then? Shouldn't your code be
> in userspace if you want to send such information to a remote system???
>
>
>
