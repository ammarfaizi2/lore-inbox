Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVCUPJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVCUPJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVCUPJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:09:54 -0500
Received: from one.firstfloor.org ([213.235.205.2]:40372 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261292AbVCUPIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:08:25 -0500
To: Dave Peterson <dave_peterson@pobox.com>
Cc: oprofile-list@lists.sf.net, bluesmoke-devel@lists.sourceforge.net,
       dsp@llnl.gov, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI handler message passing / work deferral API
References: <200503202056.02429.dave_peterson@pobox.com>
From: Andi Kleen <ak@muc.de>
Date: Mon, 21 Mar 2005 16:08:24 +0100
In-Reply-To: <200503202056.02429.dave_peterson@pobox.com> (Dave Peterson's
 message of "Sun, 20 Mar 2005 20:56:02 -0800")
Message-ID: <m1eke93ul3.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dave_peterson@pobox.com> writes:

> Below is an experimental 2.6.11.5 kernel patch that implements the
> following:
>
>      - A generic mechanism for safely passing information from NMI handlers
>        to code that executes outside NMI context.

See the machine check queueing implementation in
arch/x86_64/kernel/mce.c. It does exactly that already.

Several other architectures already have similar mechanisms.

-Andi
