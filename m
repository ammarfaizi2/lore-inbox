Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbUKKX0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbUKKX0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUKKXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:16:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:56478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262431AbUKKXLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:11:17 -0500
Date: Thu, 11 Nov 2004 15:11:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries.Brouwer@cwi.nl
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
In-Reply-To: <200411112302.iABN2Pu01711@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0411111507090.2301@ppc970.osdl.org>
References: <200411112302.iABN2Pu01711@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Nov 2004 Andries.Brouwer@cwi.nl wrote:
> 
> So, the below advises people "Say Y here" for MSDOS_PARTITION,
> and does not change the default choices when PARTITION_ADVANCED
> is selected.

Actually, we should make MSDOS_PARTITION not ask at all, unless 
CONFIG_EMBEDDED is set. 

That's really what EMBEDDED means: ask about things that no sane person 
would leave out. So how about just changing that "if PARTITION_ADVANCED" 
into "if EMBEDDED" on MSDOS?

That way PARTITION_ADVANCED really _does_ mean "do you want some
additional choices", without implying that MSDOS would be advancedl. I
absolutely agree that everybody (regardless of architecture) wants msdos
partitions, if only because they are the defacto thing for things like
removable camera media etc.

		Linus
