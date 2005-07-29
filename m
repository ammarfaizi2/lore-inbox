Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVG2SYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVG2SYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVG2SYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:24:38 -0400
Received: from magic.adaptec.com ([216.52.22.17]:37760 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262698AbVG2SYb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:24:31 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: AACRAID failure with 2.6.13-rc1
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 29 Jul 2005 14:22:37 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B017927DC@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: AACRAID failure with 2.6.13-rc1
Thread-Index: AcWUaCXAf+fkdol/QG69hdyZNNdTWAAAKLeQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Andrew Morton" <akpm@osdl.org>, "Martin Drab" <drab@kepler.fjfi.cvut.cz>
Cc: <linux-kernel@vger.kernel.org>, <markh@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin may be overplaying the performance angle.

A previous patch took the adapter from 64K to 4MB transaction sizes
across the board. This caused Martin's adapter and drive combination to
tip-over. We had to scale back to 128KB sized transactions to get
stability on his system. All systems handled the 4MB I/O size in our
tests, but the tests that were done some time ago were not performed
with the latest kernel, which contributed to a change in testing
corners.

Future patches associated with the 'new comm' interface will be able to
get finer grained performance tuning based on the adapter model rather
than the coarse method that currently resides in the more stable
kernels.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Friday, July 29, 2005 2:07 PM
To: Martin Drab
Cc: linux-kernel@vger.kernel.org; Salyzyn, Mark; markh@osdl.org
Subject: Re: AACRAID failure with 2.6.13-rc1

. . .

ah, thanks.

A temporary workaround which might affct performance sounds better than
a
dead box though.

Mark, do you think that many systems are likely to be affected this way?

Do you think we should do something temporary for 2.6.13?

