Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbUAYKub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 05:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAYKub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 05:50:31 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6784 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263880AbUAYKua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 05:50:30 -0500
Date: Sun, 25 Jan 2004 11:50:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "P. Christeas" <p_christ@hol.gr>
Cc: acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Message-ID: <20040125105038.GA2014@ucw.cz>
References: <200401251137.21646.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251137.21646.p_christ@hol.gr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 11:37:19AM +0200, P. Christeas wrote:
> This may be just a minor issue:
> I had to use the setkeycodes utility to enable some extra keys (that weren't 
> mapped by kernel's atkbd tables).
> After waking from sleep 1, those keys were reset. That is, I had to use 
> 'setkeycodes' again to customize the tables again.
> 
> IMHO the way kernel works now is correct. It should *not* have extra code just 
> to handle that. Just make sure anybody that alters his kbd tables puts some 
> extra script to recover the tables after an ACPI wake.
> This should be more like a note to Linux distributors.

Hmm, I, on the other hand don't think it's correct. Because the kernel
has extra code to delete the tables on wake, which is wrong. Thanks for
noticing.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
