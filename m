Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSIWUsL>; Mon, 23 Sep 2002 16:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSIWUsL>; Mon, 23 Sep 2002 16:48:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:19437 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261298AbSIWUsK>;
	Mon, 23 Sep 2002 16:48:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.32569.964762.776074@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 13:53:13 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, dmo@osdl.org, axboe@suse.de,
       phillips@arcor.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020923.134000.123546377.davem@redhat.com>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
	<15759.26918.381273.951266@napali.hpl.hp.com>
	<20020923.134000.123546377.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Sep 2002 13:40:00 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  >> From: David Mosberger <davidm@napali.hpl.hp.com>
  >> Date: Mon, 23 Sep 2002 12:19:02 -0700

  >> This looks like a porting-nightmare in the making.  There's got to be a
  >> better way to determine whether you need a writeq() vs. a writel().

  > Or perhaps every platform should provide a writeq(), on 32-bit systems
  > it may merely be implemented as two consequetive writel() calls.

True, but I was wondering whether driver writers will have an implicit
assumption on readX/writeX being atomic.  I don't think anyone ever
promised that, but I suspect all existing implementations are indeed
atomic (it's true even for old Alphas which don't have sub-word
load/stores).

	--david
