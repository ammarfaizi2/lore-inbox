Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWEVLd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWEVLd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 07:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWEVLd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 07:33:28 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48047 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750759AbWEVLd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 07:33:27 -0400
Subject: Re: __vmalloc with GFP_ATOMIC causes 'sleeping from invalid
	context'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
References: <20060522013648.6FCEAEE9EE@wolfe.lmc.cs.sunysb.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 May 2006 12:47:02 +0100
Message-Id: <1148298422.17376.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-05-21 at 21:36 -0400, Giridhar Pemmasani wrote:
> If __vmalloc is called in atomic context with GFP_ATOMIC flags,

vmalloc is not safely callable in a non sleeping context. If you need a
vmalloc buffer in an IRQ then pre-allocate it.

Alan

