Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTH3E7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 00:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbTH3E7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 00:59:53 -0400
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:58511
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S261240AbTH3E7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 00:59:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16208.12098.248708.643581@panda.mostang.com>
Date: Fri, 29 Aug 2003 21:59:46 -0700
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "David Mosberger-Tang" <David.Mosberger@acm.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1902C7D222@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D222@fmsmsx405.fm.intel.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: David.Mosberger@acm.org
X-URL: http://www.mostang.com/~davidm/
From: davidm@mostang.com (David Mosberger-Tang)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 29 Aug 2003 09:12:52 -0700, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> said:

  Venkatesh> The part of the patch that does the HPET initialization
  Venkatesh> for timer interrupt, and general HPET registers
  Venkatesh> read/write/programming can be common across
  Venkatesh> architectures.  However, different archs diverge, when it
  Venkatesh> comes to gettimeofday-timer implementation (tsc, pit,
  Venkatesh> itc, hpet, ) and we may still have to keep that part
  Venkatesh> architecture specific.

Is the time_interpolator interface provided by timex.h sufficient for
HPET timer-interrupt needs?  I think It ought to be.  If so, perhaps
all that's missing is that x86 needs to be switched over to that
interface?

	--david
