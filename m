Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbTFRSgm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbTFRSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:36:42 -0400
Received: from palrel10.hp.com ([156.153.255.245]:37563 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S265399AbTFRSgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:36:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.46196.394280.487990@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 11:50:28 -0700
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] input: Fix CLOCK_TICK_RATE usage ...  [8/13]
In-Reply-To: <D1BF5DC4-A19B-11D7-A24A-000A95A0560C@us.ibm.com>
References: <16111.41748.667166.867915@napali.hpl.hp.com>
	<D1BF5DC4-A19B-11D7-A24A-000A95A0560C@us.ibm.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Jun 2003 09:47:44 -0500, Hollis Blanchard <hollisb@us.ibm.com> said:

  Hollis> On Tuesday, Jun 17, 2003, at 18:24 US/Central, David Mosberger wrote:
  >> #ifdef CONFIG_LEGACY_HW
  >> # define PIT_FREQ	1193182
  >> # define LATCH		((CLOCK_TICK_RATE + HZ/2) / HZ)
  >> #endif

  >> This way, machines that support legacy hardware can define
  >> CONFIG_LEGACY_HW and on others, the macro can be left undefined, so
  >> that any attempt to compile drivers requiring legacy hw would fail to
  >> compile upfront (much better than accessing random ports!).

  Hollis> Is "having legacy hardware" an all-or-nothing condition for you? If
  Hollis> not, a CONFIG_LEGACY_PIT might be more appropriate...

I believe it is, though I'm not entirely certain about Intel's Tiger
platform.  If more fine-grained distinction really is needed, I
suspect we'd rather want something called CONFIG_8259_PIT.  Might be a
good idea to do this for all legacy devices.

	--david
