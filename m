Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUJIBMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUJIBMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUJIBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:12:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:42413 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266221AbUJIBMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:12:42 -0400
Subject: Re: Power parents
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0410081004540.1005-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0410081004540.1005-100000@ida.rowland.org>
Content-Type: text/plain
Message-Id: <1097284332.3647.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 11:12:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 00:07, Alan Stern wrote:

> My reason for asking is because having special parent pointers like that,
> without corresponding children pointers, makes it impossible to guarantee
> that parents aren't suspended until after their children when doing a
> selective suspend.

Oh, I also remember at one point toying with moving some devices to
different parents based on weird mobo design, but I dropped the idea.

> What sort of special nodes are you thinking of inserting, and how would 
> they affect selective suspend?

Oh, I'm thinking about inserting a "platform" entry between some USB
controllers and the PCI parent. On PowerMac, some of these USB controllers
are power managed via special stuffs in Apple ASICs that aren't directly
related to the PCI bus they sit on. Right now, I have hacks in the USB
HCD drivers themselves for that, but it would be cleaner just to "insert"
an entry in the power tree to do the job.

Ben.


