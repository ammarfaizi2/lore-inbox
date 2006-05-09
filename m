Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEIQpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEIQpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWEIQpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:45:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:12704 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750700AbWEIQpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [RFC PATCH 17/35] Segment register changes for Xen
Date: Tue, 9 May 2006 18:44:37 +0200
User-Agent: KMail/1.9.1
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085154.802230000@sous-sol.org>
In-Reply-To: <20060509085154.802230000@sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091844.37655.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 			/* fall through */
> --- linus-2.6.orig/include/asm-i386/mach-default/mach_system.h
> +++ linus-2.6/include/asm-i386/mach-default/mach_system.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_MACH_SYSTEM_H
>  #define __ASM_MACH_SYSTEM_H
>  
> +#define clearsegment(seg)

I don't think you can give such a specific hook such a generic name.

I would just add an ifdef around the real user with a comment.

-Andi
