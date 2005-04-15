Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVDORuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVDORuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbVDORuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:50:55 -0400
Received: from [81.2.110.250] ([81.2.110.250]:42695 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261882AbVDORuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:50:50 -0400
Subject: Re: Adaptec 2010S i2o + x86_64 doesn't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Markus.Lidel@shadowconnect.com
In-Reply-To: <1113581722.14421.15.camel@zahadum.xs4all.nl>
References: <20050413160352.GA12841@xs4all.net>
	 <1113576775.11116.17.camel@localhost.localdomain>
	 <1113581722.14421.15.camel@zahadum.xs4all.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1113587286.11114.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Apr 2005 18:48:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-04-15 at 17:15, Miquel van Smoorenburg wrote:
> However, I removed 2 GB from the box as Alan sugggested and now the box
> comes up just fine with a 64-bit 2.6.11.6 kernel! I've put the 4GB back,
> and booted with the kernel "mem=2048" command line option - that also
> works, the i2o_block driver sees the adaptec controller just fine.
> 
> And I just booted it with "mem=3840M" and that works too.
> 
> So the problem appears to be 4 GB memory in 64 bit mode, on this box.

Or the driver is incorrectly handling 64/32bit DMA limit masks which
would be my first guess here, and would explain why it works on AMD
Athlon64 boxes.

Alan

