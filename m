Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261706AbSI0PAC>; Fri, 27 Sep 2002 11:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbSI0PAC>; Fri, 27 Sep 2002 11:00:02 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8713 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261706AbSI0PAB>; Fri, 27 Sep 2002 11:00:01 -0400
Date: Fri, 27 Sep 2002 16:05:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Put modules into linear mapping
Message-ID: <20020927160520.A27591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <20020927140930.GA12610@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020927140930.GA12610@averell>; from ak@muc.de on Fri, Sep 27, 2002 at 04:09:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 04:09:30PM +0200, Andi Kleen wrote:
> +	unsigned long mptr = (unsigned long)mod;
> +	if (mptr >= VMALLOC_START && mptr+mod->size <= VMALLOC_END)

Any chance you could add is is_vmalloc() macro to vmalloc.h for this?

