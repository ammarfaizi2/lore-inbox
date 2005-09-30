Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVI3FcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVI3FcV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 01:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVI3FcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 01:32:20 -0400
Received: from thunk.org ([69.25.196.29]:61394 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932291AbVI3FcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 01:32:19 -0400
Date: Fri, 30 Sep 2005 01:31:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luben Tuikov <ltuikov@yahoo.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20050930053149.GA22199@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Willy Tarreau <willy@w.ods.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Jeff Garzik <jgarzik@pobox.com>
References: <Pine.LNX.4.58.0509291247040.3308@g5.osdl.org> <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929232013.95117.qmail@web31810.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 04:20:13PM -0700, Luben Tuikov wrote:
>
> A spec defines how a protocol works and behaves.  All SCSI specs
> are currently very layered and defined by FSMs.

A spec defines how a protocol works and behaves --- *if* it is
well-specified and unambiguous, and *if* vendors actually implement
the spec correctly.  (And sometimes vendors have major economic
incentives to cheat and either intentionally violate the
specification, or simply not bother to test to make sure whether or
not they implemented their hardware correctly.)

Computing history has been literred with specifications that were
incompentently written and/or incompentently implemented --- from the
disaster known as ACPI, to FDDI (early FDDI networking gear was
interoperable only if you bought all of your gear from one vendor,
natch), consumer-grade disks which lied about when data had been
safely written to iron oxide to garner better Winbench scores, and
many, many, many others.

This is one of the reasons why the IETF doesn't bless a networking
standard until there are multiple independent, interoperable
implementations --- and even _then_ there will be edge cases that
won't be caught until much, much later.

In those cases, if you implement something which is religiously
adherent to the specification, and it doesn't interoperate with the
real world (i.e., everybody else, or some large part of the industry)
--- do you claim that you are right because you are following the
specification, and everyone else in the world is wrong?  Or do you
adapt to reality?  People who are too in love with specifications so
that they are not willing to be flexible will generally not be able to
achieve complete interoperability.  This is the reason for the IETF
Maxim --- be conservative in what you send, liberal in what you will
accept.  And it's why interoperability testing and reference
implementations are critical.

But it's also important to remember when there is a reference
implementation, or pseudo-code in the specification, it's not the only
way you can implement things.  Very often, as Linus has pointed out,
there are reasons why the pseudo-code in the specification is wholely
inappropriate for a particular implementation.  But that's OK; the
implementation can use a different implementastion, as long as the
result is interoperable.

Regards,

						- Ted
