Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJXHmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 03:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTJXHmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 03:42:18 -0400
Received: from iv.ro ([194.105.28.94]:65440 "HELO iv.ro") by vger.kernel.org
	with SMTP id S262041AbTJXHmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 03:42:17 -0400
Date: Fri, 24 Oct 2003 10:28:42 +0300
From: Jani Monoses <jani@iv.ro>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tridentfb 2.6.0* broken for VIA integrated graphics core on
 EPIA Mini-ITX boards
Message-Id: <20031024102842.4ecc2bf7.jani@iv.ro>
In-Reply-To: <3F98D3E6.60202@t-online.de>
References: <3F98D3E6.60202@t-online.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003 09:25:26 +0200
Knut Petersen <Knut_Petersen@t-online.de> wrote:

> Oct 24 08:25:24 linux kernel: tridentfb: Trident framebuffer 
> 0.7.8-NEWAPI initializing
> Oct 24 08:25:24 linux kernel: tridentfb: framebuffer size = 8192 Kb
> Oct 24 08:25:24 linux kernel: tridentfb: 0000:01:00.0 board found
> Oct 24 08:25:24 linux kernel: tridentfb: probe of 0000:01:00.0 failed 
> with error -22

that's EINVAL and it's returned from two places in trident_pci_probe. I
suspect that find_mode does not return a valid mode. Could you look at
that function and put some more outputs...
The driver works for me in 2.6.0-test8

Jani
