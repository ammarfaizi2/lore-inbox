Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUL3KDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUL3KDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 05:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbUL3KDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 05:03:11 -0500
Received: from canuck.infradead.org ([205.233.218.70]:27659 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261607AbUL3KDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 05:03:07 -0500
Subject: Re: Stack guards, PaX and such
From: Arjan van de Ven <arjan@infradead.org>
To: David Jacoby <dj@outpost24.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41D3C66F.5070909@outpost24.com>
References: <41D3C66F.5070909@outpost24.com>
Content-Type: text/plain
Date: Thu, 30 Dec 2004 11:02:56 +0100
Message-Id: <1104400976.4170.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-30 at 10:12 +0100, David Jacoby wrote:
> Hi everyone!
> 
> I hope you had an nice and relaxing x-mas and are ready for a nice new 
> years eve.
> I just have a little question, i really dont if this has ben discussed 
> before, but if it
> has im really sorry.

are you talking about making the userspace stack not executable or the
kernel stacks?
With NX, userspace stacks already are not executable (and if you have a
cpu without NX you can use the execshield patches or PaX)

As for kernel stacks, well, with NX those are not executable either, and
to be honest, I can't remember the last time there was a user
exploitable kernel stack buffer overflow. So if your assertion is that
those are a common type of security problem, I disagree with you.
(One of the underlying causes is that the kernel stack is only really
small so it's relatively uncommon and deprecated to put arrays on the
kernel stack)


