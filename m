Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUHXHYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUHXHYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUHXHYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:24:38 -0400
Received: from palrel12.hp.com ([156.153.255.237]:58793 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266595AbUHXHYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:24:34 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16682.60718.826236.760823@napali.hpl.hp.com>
Date: Tue, 24 Aug 2004 00:24:30 -0700
To: wli@holomorphy.com
Cc: davidm@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
       Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
In-Reply-To: <20040823162735.GB4418@holomorphy.com>
References: <20040820031919.413d0a95.akpm@osdl.org>
	<200408201144.49522.jbarnes@engr.sgi.com>
	<200408201257.42064.jbarnes@engr.sgi.com>
	<20040820115541.3e68c5be.akpm@osdl.org>
	<20040820200248.GJ11200@holomorphy.com>
	<16681.45746.300292.961415@napali.hpl.hp.com>
	<20040823162735.GB4418@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Aug 2004 09:27:35 -0700, wli@holomorphy.com said:

  wli> On Fri, 20 Aug 2004 13:02:48 -0700, William Lee Irwin III said:
  William> I suppose another way to answer the question of what's
  William> going on is to fiddle with ia64's implementation of
  William> profile_pc(). I suspect something like this may reveal the
  William> offending codepaths.

  wli> On Mon, Aug 23, 2004 at 02:02:42AM -0700, David Mosberger
  wli> wrote:
  >> You do realize that q-syscollect [1] can do this better for you
  >> without touching the kernel at all?  [1]
  >> http://www.hpl.hp.com/research/linux/q-tools/

  wli> Never heard of it. Unfortunately, the issue I run into far more
  wli> frequently than tools not existing is users being unwilling or
  wli> unable to use them.

True enough.

  wli> In fact, it's even a relatively large hassle to get users to
  wli> boot with /proc/profile enabled regardless of its
  wli> simplicity.

That's why q-syscollect doesn't require any of this.  No reboot, no
kernel modules.  If you have access to an itanium 2 machine, you
really might want to try it.  (Yes, q-view, the tool to generate
gprof-like output requires guile 1.6/slib.  It comes standard wiht
Debian.)

	--david
