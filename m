Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262700AbUKRKEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUKRKEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUKRKEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:04:41 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:52444 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262700AbUKRKEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:04:20 -0500
X-Envelope-From: kraxel@bytesex.org
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       Keir.Fraser@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       alan@redhat.com
Subject: Re: [patch 3] Xen core patch : runtime VT console disable
References: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
	<20041117185652.6f8386af.akpm@osdl.org>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 18 Nov 2004 10:59:05 +0100
In-Reply-To: <20041117185652.6f8386af.akpm@osdl.org>
Message-ID: <87oehvxyty.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> >  +int console_use_vt = 1;
> 
> Should this not have static scope?

I'd like to have that one globally visible, so that code somewhere in
arch/{xen|um} can enable/disable that at boot time depending on the
virtual machine configuration.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
