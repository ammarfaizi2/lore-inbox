Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUIGU1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUIGU1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268588AbUIGU1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:27:03 -0400
Received: from the-village.bc.nu ([81.2.110.252]:48037 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268648AbUIGUQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:16:34 -0400
Subject: Re: The Serial Layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: arjanv@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1094587598.2801.24.camel@laptop.fenrus.com>
References: <1094582980.9750.12.camel@localhost.localdomain>
	 <1094587598.2801.24.camel@laptop.fenrus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094584456.9745.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 20:14:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 21:06, Arjan van de Ven wrote:
> On Tue, 2004-09-07 at 20:49, Alan Cox wrote:
> > Is anyone currently looking at fixing this before I start applying
> > extreme violence ? In particular to start trying to do something about
> > the races in TIOCSTI, line discipline setting, hangup v receive, drivers
> > abusing the API and calling ldisc.receive_buf direct ?
> 
> don't you mean the TTY layer instead of the serial layer ?

Both. A lot of hangup/receive races are in the serial drivers themselves
doing things like

	hangup
	[close ldisc]
	send bytes to the ldisc
	[Boom!]

Alan

