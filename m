Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbTL3ILN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 03:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265695AbTL3ILN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 03:11:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:17087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265693AbTL3ILM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 03:11:12 -0500
Date: Tue, 30 Dec 2003 00:11:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] optimize ia32 memmove
Message-Id: <20031230001121.48ff4d8c.akpm@osdl.org>
In-Reply-To: <3FF12FC7.5030202@pobox.com>
References: <200312300713.hBU7DGC4024213@hera.kernel.org>
	<3FF129F9.7080703@pobox.com>
	<20031229235158.755e026c.akpm@osdl.org>
	<3FF12FC7.5030202@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > "if dest is less that source, then call memcpy".  If the move is to a
>  > higher address we do it the old way.
> 
> 
>  I'm confused... that doesn't say anything to me about overlap.
> 

Overlap is OK if dest<src, because memcpy starts with the lowest address
and works upwards.


