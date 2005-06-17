Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVFQPbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVFQPbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVFQPbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:31:45 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:40331 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261997AbVFQPbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:31:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HaLKR9Ruud7lOdeVV3OHKUFs/XE0HD+Os1AUBHkOtofu8ki6ysRDPoyRwOc4QFB6mjoO67ziNkbVKAfRND/oaxqPKXCIMZiN9HwyWyc+4uqWCg5b7dV5sRco48IVk3ligbEtPQIyEPbpJSYJ/kp6YwQHccb4U4Dh3UO5LSu52yM=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Subject: Re: Need to hack kernel module of VTune (remap_page_range)
Date: Fri, 17 Jun 2005 19:37:06 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <377362e105061706426683ee01@mail.gmail.com>
In-Reply-To: <377362e105061706426683ee01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506171937.06943.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 June 2005 17:42, Tetsuji "Maverick" Rai wrote:
> I'm trying to install VTune by Intel (see
> http://www.intel.com/software/products/vtune/vlin/index.htm for
> details) but this creates a kernel module for "older" kernels; it can
> be built on my Gentoo w/kernel 2.6.11.12, but it looks for symbol
> "remap_page_range" which was used until 2.6.8 or 2.6.9.  So I would
> like to know how to hack this kernel module (fortunately sources are
> with the package).   What's the key?

You may look into this:

"remap_pfn_range()"
	http://lwn.net/Articles/104333/

Conversion to remap_pfn_range() in sound/
	http://linux.bkbits.net:8080/linux-2.6/cset@41768440y2w0JI791mgE2LQjagt5dA

It seems that s/remap_page_range/remap_pfn_range/g and shifting 3-rd argument
when needed is enough.
