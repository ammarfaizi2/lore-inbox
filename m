Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVAQJ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVAQJ1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVAQJ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:27:09 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:9367 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262744AbVAQJ0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:26:55 -0500
Date: Mon, 17 Jan 2005 10:26:54 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x8664_ksyms.c: unexport register_die_notifier
Message-ID: <20050117092654.GB29270@wotan.suse.de>
References: <20050116074649.GW4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116074649.GW4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2005 at 08:46:49AM +0100, Adrian Bunk wrote:
> The only user of register_die_notifier (kernel/kprobes.c) can't be 
> built modular. Therefore, it's the EXPORT_SYMBOL is superfluous.

Please don't apply this, it was especially intended for modular debuggers.
There is already a hacvked kdb around that uses it.

-Andi
