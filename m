Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbUCXRMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263783AbUCXRMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:12:43 -0500
Received: from palrel11.hp.com ([156.153.255.246]:64699 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263780AbUCXRMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:12:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.49534.124281.434663@napali.hpl.hp.com>
Date: Wed, 24 Mar 2004 09:12:30 -0800
To: John Reiser <jreiser@BitWagon.com>
Cc: davidm@hpl.hp.com, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
In-Reply-To: <4061B764.5070008@BitWagon.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
	<16480.55450.730214.175997@napali.hpl.hp.com>
	<4060E24C.9000507@redhat.com>
	<16480.59229.808025.231875@napali.hpl.hp.com>
	<20040324070020.GI31589@devserv.devel.redhat.com>
	<16481.13780.673796.20976@napali.hpl.hp.com>
	<20040324072840.GK31589@devserv.devel.redhat.com>
	<16481.15493.591464.867776@napali.hpl.hp.com>
	<4061B764.5070008@BitWagon.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 08:29:24 -0800, John Reiser <jreiser@BitWagon.com> said:

  Jakub> but it is still possible some language interpreter or
  Jakub> something builds code on the fly on the stack).

  David> That's why there is mprotect().

  John> But mprotect() costs enough (hundreds of cycles) to be a
  John> significant burden in some cases.  Generating code to a stack
  John> region that is inherently executable is inexpensive (even
  John> allowing for restrictive alignment and avoiding I/D cache
  John> conflicts), is thread safe, is async-signal safe, and takes
  John> less work than other alternatives.  Yes, the "black hats" do
  John> this; so do the "white hats."  Please do not increase the
  John> minimum cost for applications that want generate-and-execute
  John> on the stack at upredictable high frequency.

Huh?  Only one mprotect() call is needed to make the entire stack
executable.

	--david
