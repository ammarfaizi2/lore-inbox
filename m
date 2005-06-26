Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVFZR6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVFZR6d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVFZR6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:58:33 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:55750 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261490AbVFZR6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:58:30 -0400
Subject: Re: [PATCH] Allow number of IDE interfaces to be selected (X86)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Warne <nick@linicks.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506251641.40922.nick@linicks.net>
References: <200506251641.40922.nick@linicks.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119808554.28649.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 18:55:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-06-25 at 16:41, Nick Warne wrote:
> A small patch I done to allow X86 users to select the max number of IDE 
> interfaces they have - this eliminates the need for passing idex=noprobe on 
> the command line and/or stops the needless probes at boot on non-existant IDE 
> interfaces.

The needless probe cases patch went into -mm already. Also your change
doesn't eliminate the need for noprobe in cases where its not the first
or second interface in order.

The assumption most x86 users will only have two IDE interfaces is also
generally wrong today, although they may fall under the SATA driver on
newer boards.

I don't think this patch should go in - the one real reason for having
it in embedded boxes was saving memory. The right fix for that is
already something Bartlomiej has talked about fixing - the static
allocation of the ide_hwifs array itself.

Alan

