Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWDFDmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWDFDmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 23:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWDFDmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 23:42:23 -0400
Received: from smtp-out.google.com ([216.239.45.12]:16767 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751361AbWDFDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 23:42:23 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=QywT3mim1xJiKnm2flSB/Z663sl8xnmKBHVi5kkvj+eFT9FHFSXmPeiJ8YzdOUMpd
	gAyfX5uCeuhEko3nN2egQ==
Message-ID: <44348E08.1050502@google.com>
Date: Wed, 05 Apr 2006 20:42:00 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 12/16] UML - Memory hotplug
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org> <20060325010524.GA8117@ccure.user-mode-linux.org> <44343E86.30301@google.com> <20060406015636.GE6924@ccure.user-mode-linux.org>
In-Reply-To: <20060406015636.GE6924@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> Yeah, it's a bit non-obvious what 0 means in the twisty little maze of
> GFP_ flags.
> 
> However, I do want to push the system into reclaim later.  It looks
> like the only difference between 0 and GFP_ATOMIC is the use of
> emergency pools, which I don't really want to exercise anyway.
> 
> ...This look OK to you?...
> 
> +			/* 0 means don't wait (like GFP_ATOMIC) and
> +			 * don't dip into emergency pools (unlike
> +			 * GFP_ATOMIC).
> +			 */
> +			new = kmalloc(sizeof(*new), 0);

If you have a believable use for gfp_mask=0 then why not add GFP_NOWAIT or some
such to gfp.h?

Regards,

Daniel
