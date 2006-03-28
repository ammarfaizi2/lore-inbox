Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWC1SlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWC1SlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 13:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWC1SlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 13:41:24 -0500
Received: from xenotime.net ([66.160.160.81]:20643 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751247AbWC1SlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 13:41:24 -0500
Date: Tue, 28 Mar 2006 10:43:37 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Shlomi Fish <shlomif@iglu.org.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PoC "make xconfig" Search Facility
Message-Id: <20060328104337.bb646fad.rdunlap@xenotime.net>
In-Reply-To: <200603272150.42305.shlomif@iglu.org.il>
References: <200603272150.42305.shlomif@iglu.org.il>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006 21:50:41 +0200 Shlomi Fish wrote:

> Hi all!
> 
> [ I'm not subscribed to this list so please CC me on your replies. ]
> 
> This patch adds a proof-of-concept search facility to "make xconfig". Current 
> problems and limitations:
> 
> 1. Only case-insensitive single-substring search is supported.
> 
> 2. The style is completely wrong, as I could not find a suitable vim 
> configuration for editing Linux kernel source (and Google was not help). If 
> anyone can refer me to one, I'll be grateful.

I don't know of a vim config for kernel source code.
Just read/use Documentation/CodingStyle, although for this code that probably
doesn't matter so much (since this isn't kernel run-time code).

> 3. At the moment the results are displayed in a listbox as text. One cannot go 
> from the result node to the place to toggle it in the configuration. (much 
> less from one of it ancessorts)
> 
> But it works!
> 
> The patch is against kernel 2.6.16-git13.
> 
> Comments, suggestions, corrections, and flames are welcome.

Thanks.  It's useful and a good start.

A one-line comment about how to invoke it would have been nice:
Use Edit/Find or Ctrl-F to invoke the search (find) tool.

To be really useful it needs to display items that SELECT the search string
IMO.  Look at how menuconfig can do that.

E.g., for FW_LOADER (my favorite because it keeps me from disabling HOTPLUG
so often), using /FW_LOADER in menuconfig tells me what SELECTs FW_LOADER
as well as where it's defined.

Being able to enter more queries without leaving the dialog box is nice/good.

Oh, and patches should apply with 'patch -p1' (i.e., their filenames should
begin with linux-tree/scripts/ etc., not with scripts/*).

---
~Randy
