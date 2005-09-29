Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVI2XUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVI2XUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVI2XUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:20:16 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:3719 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751361AbVI2XUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:20:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GMubmYsh/xTnO0Eu5dfZy2gYUE6tcB8IYHo6k1aPNny6KLUR7zfmUesg2quvzYElfo8W+9xe1qpkIB0oEcjwOKkhhHcn/Hlul264txJ1tIPe30A6b/y8EnLXY3XuqsIjGLn4AKabk2qxaJOUHLGA3W27qxvPFIfO8PaVbOerszg=  ;
Message-ID: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 16:20:13 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
To: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0509291247040.3308@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Linus Torvalds <torvalds@osdl.org> wrote:
> 
> A "spec" is close to useless. I have _never_ seen a spec that was both big 
> enough to be useful _and_ accurate.
> 
> And I have seen _lots_ of total crap work that was based on specs. It's 
> _the_ single worst way to write software, because it by definition means 
> that the software was written to match theory, not reality.

A spec defines how a protocol works and behaves.  All SCSI specs
are currently very layered and defined by FSMs.

This is _the reason_ I can plug in an Adaptec SAS host adapter
to Vitesse Expander which has a Seagate SAS disk attached to phy X...
And guess what? They interoperate and communicate with each other.

Why?  Because at each layer (physical/link/phy/etc) each
one of them follow the FSMs defined in the, guess where, SAS spec.

If you take a SAS/SATA/FC/etc course, they _show you_ a link
trace and then _show_ you how all of it is defined by the FSM
specs, and make you follow the FSMs.

> So there's two MAJOR reasons to avoid specs:

Ok, then I accept that you and James Bottomley and Christoph are
_right_, and I'm wrong.

I see we differ in ideology.

>    It's like real science: if you have a theory that doesn't match 
>    experiments, it doesn't matter _how_ much you like that theory. It's
>    wrong. You can use it as an approximation, but you MUST keep in mind 
>    that it's an approximation.

But this is _the_ definition of a theory.  No one is arguing that
a theory is not an approximation to observed behaviour.

What you have here is interoperability. Only possible because
different vendors follow the same spec(s).

>  - specs have an inevitably tendency to try to introduce abstractions
>    levels and wording and documentation policies that make sense for a 
>    written spec. Trying to implement actual code off the spec leads to the 
>    code looking and working like CRAP. 

Ok, I give up: I'm wrong and you and James B are right.

>    The classic example of this is the OSI network model protocols. Classic 

Yes, it is a _classic_ example and OSI is _very_ old.

_But_ the tendency of representing things in a _layered_, object oriented
design has persisted.

>    spec-design, which had absolutely _zero_ relevance for the real world. 
>    We still talk about the seven layers model, because it's a convenient 
>    model for _discussion_, but that has absolutely zero to do with any 
>    real-life software engineering. In other words, it's a way to _talk_ 
>    about things, not to implement them.

Ok.
 
>    And that's important. Specs are a basis for _talking_about_ things. But 
>    they are _not_ a basis for implementing software.

Ok.  Let's forget about maintenance and adding _new_ functionality.
 
> So please don't bother talking about specs. Real standards grow up 
> _despite_ specs, not thanks to them.

Yes, you're right. Linus is always right.

Now to things more pertinent, which I'm sure people are interested in:

Jeff has been appointed to the role of integrating the SAS code
with the Linux SCSI _model_, with James Bottomley's "transport attributes".
So you can expect more patches from him.

Regards,
    Luben

P.S. I have to get this 8139too.c network card here working.

