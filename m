Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVKUIcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVKUIcW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKUIcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:32:21 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33001
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932224AbVKUIcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:32:19 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] skip initramfs check
Date: Mon, 21 Nov 2005 01:30:55 -0600
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Matt Mackall <mpm@selenic.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <20051117141432.GD9753@logos.cnet>
In-Reply-To: <20051117141432.GD9753@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511210130.55774.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 November 2005 08:14, Marcelo Tosatti wrote:
> Hi,
>
> The initramfs check at populate_rootfs() can consume significant time
> (several seconds) on slow/embedded platforms, since it has to decompress
> the image.

Query: is the problem that a big initramfs image is being unpacked more than 
once, or is unpacking an empty initramfs image (134 bytes) causing a 
significant delay?

I'm fairly certain that back in 1990 I could unzip 134 bytes on my 33 mhz 386 
running dos in a fraction of a second.  What's the use case here?

Rob
