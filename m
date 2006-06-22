Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWFVKuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWFVKuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWFVKuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:50:07 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:58178 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161060AbWFVKuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:50:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mst7ST63HZc42YX450GfKiyGiB+qFzd5HDDi6Re18Gj4j5JZ5pOzrPFts5OWLhZnC7S4hEogbGBX/dFzI1+EZFli1BsFBs9hvBBmRuauX+P8UNt2Cmx+coXja7dnhSclPgmAdMbY76bVjoi1khYzsAXqSJPB9ePxAKY0ITF8Y3Y=
Message-ID: <449A75D6.7010200@gmail.com>
Date: Thu, 22 Jun 2006 18:49:58 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Edgar Hucek <hostmaster@ed-soft.at>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based Macs [try #3]
References: <4499A25A.1020508@ed-soft.at>
In-Reply-To: <4499A25A.1020508@ed-soft.at>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Hucek wrote:
> This patch add a new framebuffer driver for the Intel Based macs.
> This framebuffer is needed when booting from EFI to get something
> out the box   ;) 
> [try #2] Removed unused and untested code in this version of the patch.
> [try #3] Just cleanup to meet the coding guideline.
> 
> Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>
Acked-by: Antonino Daplas <adaplas@pol.net>

I'll pick this up if Andrew or Linus doesn't.

Tony

> +#define	DEFAULT_FB_MEM	1024*1024*16

nitpick: parenthesis around the value?


> +
> +static struct platform_device imacfb_device = {
> +	.name	= "imacfb",
> +};

You might update this sometime in the future to use
platform_device_alloc().

