Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWEJKyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWEJKyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWEJKyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:54:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:8352 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964917AbWEJKyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:54:33 -0400
From: Andi Kleen <ak@suse.de>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Date: Wed, 10 May 2006 12:54:26 +0200
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <200605092356.28818.ak@suse.de> <20060510103520.GX7834@cl.cam.ac.uk>
In-Reply-To: <20060510103520.GX7834@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101254.26870.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

es, which is why I measured that one as well.
> 
> Now, the original concern was that we have the five operations implemented
> as multi-line macros and doing a hybrid solution doesn't really address
> that.

If it's straight-forward to convert to an inline do it. If not keep
it as a macro. After all code style is just a tool, not something
self serving.

> 
> Also, it's not quite clear to me what's the best way to turn three of
> the five into functions, whether inline or not.
> 
> For measuring the sizes, I did the following:
> add void ___restore_flags(unsigned long *x) with the implementation
> and then:
> #define __restore_flags(x) ___restore_flags(&(x))

Yes that is the standard way to do it 

> Alternatively, would it make sense to change __restore_flags to take
> a pointer to flags instead?  That would be quite an invasive change...

No.

-Andi

