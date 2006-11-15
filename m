Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965894AbWKODV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965894AbWKODV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 22:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965613AbWKODV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 22:21:56 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:28521 "EHLO
	stargate.chelsio.com") by vger.kernel.org with ESMTP
	id S965817AbWKODVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 22:21:55 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 14 Nov 2006 19:21:38 -0800
Message-ID: <8A71B368A89016469F72CD08050AD334DA4851@maui.asicdesigners.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
Thread-Index: AccIZSl938PEQ614Q7GnwjzB+M2Ewg==
From: "Felix Marti" <felix@chelsio.com>
To: <linux-kernel@vger.kernel.org>, <jeff@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff wrote:
> A bit of history:  this driver was merged in March 2005 (submitted by 
> Chelsio), updated once in June 2005, and then the maintainers
completely 
> disappeared.
>
> So, you get what you get...  if someone wants to dig through the
updated 
> cxgb driver and merge it with the kernel and test it... great.  But at

> this point it is abandonware.
>
>	Jeff

Jeff, as indicated by Chris, the driver that is in the kernel is for
N110 and N210. So far, we have not received any customer complaints
regarding bugs in the driver and thus it has not been updated in a long
time. If you feel like there are some missing features/bug fixes, I'd be
glad to spend some time on it.

However, Chris's initial request is regarding support for T210. As you
indicate, the T210 product is a superset of N110/N210 and i.e. supports
TOE. Since the T210 board features additional pieces of hardware, these
must be initialized (i.e. memory controllers and TCAM) even if the board
is to be used as a NIC only. If the kernel developers are okay with
these additional initialization procedures we could update the driver to
support N as well as T based products, in NIC mode only, of course ;)

felix
