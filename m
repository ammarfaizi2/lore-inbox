Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVAKXqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVAKXqr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVAKXol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:44:41 -0500
Received: from one.firstfloor.org ([213.235.205.2]:40641 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262965AbVAKXm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:42:59 -0500
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: node_online_map patch kills x86_64
References: <20050111151656.A24171@build.pdx.osdl.net>
From: Andi Kleen <ak@muc.de>
Date: Wed, 12 Jan 2005 00:42:57 +0100
In-Reply-To: <20050111151656.A24171@build.pdx.osdl.net> (Chris Wright's
 message of "Tue, 11 Jan 2005 15:16:56 -0800")
Message-ID: <m1d5wb4jni.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> Backing out the x86_64 specific bits of the numnodes -> node_online_map
> patch and the generic bits from wli, kills my machine at boot.

And with it it included it works? Why do you back it out then? 
>
> It hits the early_idt_handler and dies straight away.  What would help
> to debug this thing?

First a bit of information, like what kind of machine, logs etc.
(kernel bug reporting 101, it's not that difficult, isn't it?) 

If you have a dual Opteron system and enabled CONFIG_ACPI_NUMA
then numa=noacpi may work. There is a known problem with some
Tyan BIOS. Fix for that is upcomming.

-Andi
