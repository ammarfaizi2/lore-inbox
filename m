Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbTERXUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTERXUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:20:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:4994 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S262262AbTERXUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:20:31 -0400
Date: Mon, 19 May 2003 00:33:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@muc.de>, kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030518233325.GA8888@mail.jlokier.co.uk>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk> <20030518053935.GA4112@averell> <20030518161105.GA7404@mail.jlokier.co.uk> <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk> <20030518223446.GA8591@mail.jlokier.co.uk> <20030518225204.GA21068@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030518225204.GA21068@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  > If that's the problem, a test which writes a data pattern to a
>  > significant chunk of video RAM in sequence, as fast as possible, and
>  > then reads it would be practically guaranteed to spot this and
>  > indicate that MTRRs aren't suitable for this card in this mode.
> 
> Or you could just add the PCI ID to the quirks list..

My point being that vesafb is used for maximum compatibility, when you
have no other way to drive an unknown framebuffer.  It's the emergency
backup driver.  Shouldn't it be robust when faced with an unknown
framebuffer type, new or old?

Granted if there are only two cards with this problem and we are
confident that no other cards have the problem, a PCI ID would do it.

-- Jamie

