Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVKBHBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVKBHBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKBHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:01:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932451AbVKBHBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:01:03 -0500
Date: Wed, 2 Nov 2005 17:00:53 +1100
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] slob: move kstrdup to lib/string.c
Message-Id: <20051102170053.1c120a03.akpm@osdl.org>
In-Reply-To: <2.494767362@selenic.com>
References: <2.494767362@selenic.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> This move kstrdup to lib/string.c

The placement in slab.c was deliberate.  Putting it in lib/string.c breaks
ppc32.

ppc32 is reusing lib/string.c to build early userspace or something
like that, and calling kmalloc from there broke stuff.
