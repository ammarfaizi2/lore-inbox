Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVAXUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVAXUWs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVAXUVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:21:05 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:60575
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261620AbVAXUUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:20:46 -0500
Date: Mon, 24 Jan 2005 15:20:35 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Ian Campbell <icampbell@arcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: use datacs is smc91x driver
In-Reply-To: <1106569302.19123.49.camel@icampbell-debian>
Message-ID: <Pine.LNX.4.61.0501241459090.7307@localhost.localdomain>
References: <1106569302.19123.49.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Ian Campbell wrote:

> Hi Nico,
> 
> Below is a first cut at supporting the second 32-bit DATACS chipselect
> in the smc91x driver to transfer data.

[...]

> I'm not entirely happy with using the SMC_*_RESOURCE defines to find the
> correct resources, but I don't think you can have a placeholder for the
> attrib space at index 1 (when you don't have an attrib space) and still
> have datacs at index 2.

I don't like that either.  Maybe the whole thing should be converted to 
use platform_get_resource_byname() ?


Nicolas
