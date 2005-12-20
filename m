Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVLTUPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVLTUPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVLTUPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:15:13 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50079 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751065AbVLTUPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:15:11 -0500
Subject: Re: About 4k kernel stack size....
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Lord <lkml@rtr.ca>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>, nel@vger.kernel.org
In-Reply-To: <43A77205.2040306@rtr.ca>
References: <20051218231401.6ded8de2@werewolf.auna.net>
	 <43A77205.2040306@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 20:15:47 +0000
Message-Id: <1135109747.25010.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-12-19 at 21:52 -0500, Mark Lord wrote:
> The mainline code paths are undoubtedly fine with 4K stacks.
> It's the *error paths* that are most likely to go deeper on the stack,
> and those are rarely exercised by anyone.  And those are the paths
> that we *really* need to be reliable.

Very few error paths are that deep, the obvious complex exception is the
scsi one, but thats a seperate thread. Also the same argument about
reliability is why going to 4K stack + IRQ stacks helps - it makes the
stack usage predictable.

