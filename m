Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVLFUGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVLFUGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVLFUGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:06:05 -0500
Received: from web32108.mail.mud.yahoo.com ([68.142.207.122]:52620 "HELO
	web32108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932278AbVLFUGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:06:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Mj2/zuk/g7cAXSZaH8pyMXpPMukcInnGtMmEKy5uFpBBlIvXEo1R5jlAmPqh47p+urZk28hYgltorBYXZ3xOug+JHmGGdy11np0+hEHXkLwHPhO7jv3roH/44GCGTlRCXpqTe+368rasupVBBDbUwljnyYYmbDXD5N8vVvDUfek=  ;
Message-ID: <20051206200558.41422.qmail@web32108.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 12:05:58 -0800 (PST)
From: Vinay Venkataraghavan <raghavanvinay@yahoo.com>
Subject: Re: copy_from_user/copy_to_user question
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0512061314560.5396@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, sorry for all the questions. I really appreciate
everybody's help and especially Steve for standing up
for me!! All the reasons you cited are true and that
is why I am afraid I cannot post the actual code etc.

There was never a question in my mind that we have to
use the *_user functions. I was just trying to
understand all the corner cases and the semantics of
how things worked when it has not been used. 

Thanks once again.
Signing off this thread.
Vinay


--- "linux-os (Dick Johnson)" <linux-os@analogic.com>
wrote:

> 
> On Tue, 6 Dec 2005, Vinay Venkataraghavan wrote:
> 
> >
> > Thanks to Steve and everybody who sent such
> detailed
> > and timely responses to my question.
> >
> > The motivation for the copy to user question is
> due to
> > the handling of ioctl calls in the driver for a
> chip
> > that is widely used. I just could not beleive that
> > they would/could commit such a mistake.
> >
> > It looks like the old driver code still seems to
> work
> > even without performing copy_to_user and
> > copy_from_user.
> >
> > But this brings about another scenario. What if
> the
> > case statement in the ioctl call only needs to
> have
> > access to the members of the structure passed in
> > through the arg pointer but does not need to
> modify
> > these values and return values.
> >
> > Is this still a problem if copy_to_user and
> > copy_from_user is not used?
> >
> > Thanks,
> > Vinay
> 
> If you __access__(note) user-mode data from the
> kernel, you __must__
> use the appropriate /copy/to/from/get/put/user
> functions and/or
> macros. And, you __must__ not be in a spin-lock, or
> otherwise have
> the interrupts disabled, while doing it. There are
> no exceptions.
> 
> (note)__assess__ means even "peek at".
> 
> FYI, there should never even be such a question.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine
> (5589.55 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> 
>
****************************************************************
> The information transmitted in this message is
> confidential and may be privileged.  Any review,
> retransmission, dissemination, or other use of this
> information by persons or entities other than the
> intended recipient is prohibited.  If you are not
> the intended recipient, please notify Analogic
> Corporation immediately - by replying to this
> message or by sending an email to
> DeliveryErrors@analogic.com - and destroy all copies
> of this information, including any attachments,
> without reading or disclosing them.
> 
> Thank you.
> 



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

