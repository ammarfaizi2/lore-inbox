Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWBUUEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWBUUEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 15:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWBUUEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 15:04:11 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7820
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932650AbWBUUEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 15:04:10 -0500
Date: Tue, 21 Feb 2006 12:01:43 -0800 (PST)
Message-Id: <20060221.120143.15763934.davem@davemloft.net>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: softlockup interaction with slow consoles
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p73mzgk4y9u.fsf@verdi.suse.de>
References: <Pine.LNX.4.58.0602210404330.3092@devserv.devel.redhat.com>
	<20060221.011650.120896368.davem@davemloft.net>
	<p73mzgk4y9u.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2006 14:49:49 +0100

> Still you could probably see problems with very slow consoles even
> after bootup, couldn't you?

Yes, others have mentioned this too, good point.

Depending upon what we're really trying to achieve with the
softlockup stuff, we can perhaps look into increasing the
timeout or making it configurable.  We could even do this
dynamically, so when we register a serial console running
at some low baud rate, we scale up the softlockup timeout
or something like that.
