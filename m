Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSIWVTk>; Mon, 23 Sep 2002 17:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbSIWVTO>; Mon, 23 Sep 2002 17:19:14 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:28665 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261377AbSIWVTK>;
	Mon, 23 Sep 2002 17:19:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.34428.608321.969391@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 14:24:12 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, dmo@osdl.org, axboe@suse.de,
       phillips@arcor.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020923.135708.10698522.davem@redhat.com>
References: <15759.26918.381273.951266@napali.hpl.hp.com>
	<20020923.134000.123546377.davem@redhat.com>
	<15759.32569.964762.776074@napali.hpl.hp.com>
	<20020923.135708.10698522.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Sep 2002 13:57:08 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  >> On many platforms, two consequetive __raw_writel()'s might even
  >> combine to an atomic 64-bit store to PCI space. :-)

Yes, but that's no guarantee.

  >> I don't think the proposed 32-bit behavior is off the mark, and
  >> anyways x86 can actually make the 64-bit store I believe if it
  >> wants at least on more recent processors.

Surely we wouldn't want to define a new API that can't be supported on
all 32-bit platforms, no?  Perhaps writeq_nonatomic()?

	--david
