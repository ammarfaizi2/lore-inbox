Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUFGSma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUFGSma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUFGSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 14:42:29 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7098 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264986AbUFGSm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 14:42:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16580.46864.290708.33518@napali.hpl.hp.com>
Date: Mon, 7 Jun 2004 11:42:24 -0700
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using getpid() often, another way? [was Re: clone() <-> getpid() bug in 2.6?]
In-Reply-To: <20040607140009.GA21480@infradead.org>
References: <40C1E6A9.3010307@elegant-software.com>
	<Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	<40C32A44.6050101@elegant-software.com>
	<40C33A84.4060405@elegant-software.com>
	<1086537490.3041.2.camel@laptop.fenrus.com>
	<40C3AD9E.9070909@elegant-software.com>
	<20040607121300.GB9835@devserv.devel.redhat.com>
	<6uu0xn5vio.fsf@zork.zork.net>
	<20040607140009.GA21480@infradead.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 7 Jun 2004 15:00:09 +0100, Christoph Hellwig <hch@infradead.org> said:

  Christoph> On Mon, Jun 07, 2004 at 02:48:31PM +0100, Sean Neakums
  Christoph> wrote:
  >> > for example ia64 doesn't have it.

  >> Then what is the sys_clone2 implementation in
  >> arch/is64/kernel/entry.S for?

  Christoph> It's clone with a slightly different calling convention.

Note that the only difference is that the stack-area is expressed as a
range (starting-address + size), rather than a direct stack-pointer
value.  IMHO, it was a mistake to not do it that way right from the
beginning (consider that different arches grow stacks in different
directions, for example).

	--david
