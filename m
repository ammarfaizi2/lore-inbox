Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbUCJQtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUCJQtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:49:19 -0500
Received: from palrel10.hp.com ([156.153.255.245]:20378 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262718AbUCJQtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:49:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16463.18183.341946.76971@napali.hpl.hp.com>
Date: Wed, 10 Mar 2004 08:49:11 -0800
To: Wouter Lueks <wouter@telox.net>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <20040310075211.GA8375@telox.net>
References: <16457.26208.980359.82768@napali.hpl.hp.com>
	<4049FE57.2060809@pacbell.net>
	<20040308061802.GA25960@cup.hp.com>
	<16460.49761.482020.911821@napali.hpl.hp.com>
	<404CEA36.2000903@pacbell.net>
	<16461.35657.188807.501072@napali.hpl.hp.com>
	<404E00B5.5060603@pacbell.net>
	<16462.1463.686711.622754@napali.hpl.hp.com>
	<404E2B98.6080901@pacbell.net>
	<16462.48341.393442.583311@napali.hpl.hp.com>
	<20040310075211.GA8375@telox.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Mar 2004 08:52:12 +0100, Wouter Lueks <wouter@telox.net> said:

  Wouter> I'm doing my best to track this thread altough I cannot
  Wouter> understand the technical stuff I belive you are havily
  Wouter> tracking down a bug in the ohci-hcd, but, according to the
  Wouter> problems I expierienced, there is a similar bug in uhci-hcd.

That's possible but it's not necessarily the case.  There is one real
bug in the hid-input.c which would cause a hang on single-CPU machines
when connecting the BTC keyboard.  See this mail (patch included):

  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107889747301413

There also seems to be a bug in the BTC keyboard which causes the
hid-core to time out when initializing the keyboard.  That problem
isn't fatal, but it's annoying to have to wait for 10+ seconds to wait
for the keyboard to become online.  A workaround for this bug can be
found in this mail:

  http://marc.theaimsgroup.com/?l=linux-usb-devel&m=107889855108618

I'd be interested in hearing if that fixes the problems for your machine.

	--david

