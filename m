Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWHXNlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWHXNlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 09:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWHXNlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 09:41:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751381AbWHXNlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 09:41:02 -0400
Subject: Re: [PATCH] BLOCK: Make it possible to disable the block layer
From: David Woodhouse <dwmw2@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <778.1156426456@warthog.cambridge.redhat.com>
References: <1156425193.3012.32.camel@pmac.infradead.org>
	 <32640.1156424442@warthog.cambridge.redhat.com>
	 <778.1156426456@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 14:40:59 +0100
Message-Id: <1156426859.3012.36.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 14:34 +0100, David Howells wrote:
> Ah, but...  The core kernel makes use of the certain header files, even when
> their actual intended target is compiled as a module.  If I just use
> "CONFIG_foo" only, then the module won't compile as a module. 

So don't put it in the header file itself. Just do 

	#ifdef CONFIG_foo
	#include <linux/foo.h>
	#endif

Better still, avoid the need for the external code to poke at fs-private
header files at all.

-- 
dwmw2

