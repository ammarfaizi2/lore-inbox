Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUFDXT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUFDXT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUFDXTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:19:17 -0400
Received: from purplechoc.demon.co.uk ([80.176.224.106]:4225 "EHLO
	skeleton-jack.localnet") by vger.kernel.org with ESMTP
	id S266070AbUFDXQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:16:42 -0400
Date: Sat, 5 Jun 2004 00:16:25 +0100
To: Ian Abbott <abbotti@mev.co.uk>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Message-ID: <20040604231625.GC4087@skeleton-jack>
References: <40C08E6D.8080606@infosciences.com> <c9q8a6$hga$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9q8a6$hga$1@sea.gmane.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:34:41PM +0100, Ian Abbott wrote:
> 
> A related problem with the current implementation is that is easy to 
> run out of memory by running something similar to this:
> 
>  # cat /dev/zero > /dev/ttyUSB0
> 

I got bitten by this a couple of days ago. There is effectively no write
flow control at all, it just sucks up memory ...

P.
