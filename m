Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSIWTQH>; Mon, 23 Sep 2002 15:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSIWTP0>; Mon, 23 Sep 2002 15:15:26 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:37568 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261353AbSIWTOK>;
	Mon, 23 Sep 2002 15:14:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.26918.381273.951266@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 12:19:02 -0700
To: Dave Olien <dmo@osdl.org>
Cc: axboe@suse.de, phillips@arcor.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020923120400.A15452@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

>>>>> On Mon, 23 Sep 2002 12:04:00 -0700, Dave Olien <dmo@osdl.org> said:

  Dave> #ifdef __ia64__
  Dave> -  writeq(Virtual_to_Bus64(CommandMailbox),
  Dave> +  writeq(CommandMailboxDMA,
  Dave> ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
  Dave> #else
  Dave> -  writel(Virtual_to_Bus32(CommandMailbox),
  Dave> +  writel(CommandMailboxDMA,
  Dave> ControllerBaseAddress + DAC960_LP_CommandMailboxBusAddressOffset);
  Dave> #endif

This looks like a porting-nightmare in the making.  There's got to be a
better way to determine whether you need a writeq() vs. a writel().

	--david
