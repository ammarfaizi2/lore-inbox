Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265333AbUAZBIg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAZBIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:08:36 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:61662 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265333AbUAZBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:08:35 -0500
Date: Mon, 26 Jan 2004 02:08:32 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Message-ID: <20040126010832.GA5462@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040125115129.GA10387@merlin.emma.line.org> <20040125151454.70b5011e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125151454.70b5011e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Andrew Morton wrote:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> >
> >  Loading the parport_pc modules crashes in 2.6.2-rc; I have recently done
> >  a "bk pull" and enabled some PNP options, among them ISA PNP.
> 
> Often this is because some other, unrelated module left things registered
> after it was removed.  Or otherwise wrecked shared data structures.

The breakage is somehow related to CONFIG_PNP. I set that option to N,
ran "make oldconfig ; make", installed the kernel, rebooted, problem
gone.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
