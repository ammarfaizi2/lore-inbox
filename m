Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUCXSCA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 13:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUCXSCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 13:02:00 -0500
Received: from palrel12.hp.com ([156.153.255.237]:49878 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262850AbUCXSBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 13:01:39 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.52480.21178.836408@napali.hpl.hp.com>
Date: Wed, 24 Mar 2004 10:01:36 -0800
To: Jakub Jelinek <jakub@redhat.com>
Cc: davidm@hpl.hp.com, John Reiser <jreiser@BitWagon.com>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040324172454.GP31589@devserv.devel.redhat.com>
References: <20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<20040324070020.GI31589@devserv.devel.redhat.com>
	<16481.13780.673796.20976@napali.hpl.hp.com>
	<20040324072840.GK31589@devserv.devel.redhat.com>
	<16481.15493.591464.867776@napali.hpl.hp.com>
	<4061B764.5070008@BitWagon.com>
	<16481.49534.124281.434663@napali.hpl.hp.com>
	<20040324172454.GP31589@devserv.devel.redhat.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 12:24:54 -0500, Jakub Jelinek <jakub@redhat.com> said:

  >> Huh?  Only one mprotect() call is needed to make the entire stack
  >> executable.

  Jakub> Nope.  Think about multithreaded apps.

I said one mprotect() to make the entire stack executable.  Obviously,
if you have multiple stacks, you need one call per stack.  Big deal.

  Jakub> Furthermore, getting the exact extents of the particular
  Jakub> stack is difficult to find for applications, but e.g. the
  Jakub> threading library has to know such things.

And how is this a kernel problem?  There are other reasons why
applications need to know the stack extents (think garbage collector)
and it's entirely glibc's failing if it's difficult to determine the
stack extent.

	--david
