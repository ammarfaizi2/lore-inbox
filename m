Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUJKOFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUJKOFI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268987AbUJKOFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:05:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52877 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268981AbUJKOE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:04:56 -0400
Date: Mon, 11 Oct 2004 15:04:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Pavel Roskin <proski@gnu.org>
Cc: Cal Peake <cp@absolutedigital.net>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Fix readw/writew warnings in drivers/net/wireless/hermes.h
Message-ID: <20041011140454.GW23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0410110702590.7899@linaeum.absolutedigital.net> <Pine.LNX.4.61.0410110858350.4733@portland.hansa.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410110858350.4733@portland.hansa.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 09:12:03AM -0400, Pavel Roskin wrote:
> Another, more sophisticated solution would be to use union for iobase:
> 
> typedef struct hermes {
>         union {
>                 unsigned long io;
>                 void *mem;
>         } base;
>         int io_space; /* 1 if we IO-mapped IO, 0 for memory-mapped IO? */
> 	...
> }

Not needed.  Use ioread*/iowrite* family; it does what you need.

Al, putting together a patchset and documention on that sort of cleanups...
