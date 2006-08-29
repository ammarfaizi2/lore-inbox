Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWH2LcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWH2LcR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWH2LcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:32:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:5357 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964928AbWH2LcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:32:16 -0400
Date: Tue, 29 Aug 2006 12:31:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT] sched.h removal from module.h
Message-ID: <20060829113159.GB23975@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
References: <20060827153234.GA31505@martell.zuzino.mipt.ru> <44F39403.4060909@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F39403.4060909@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 11:10:27AM +1000, Nick Piggin wrote:
> >This is done by duplicating prototype of wake_up_process() which seems
> >to be the only thing module.h wants.
> 
> This is really ugly, IMO. It makes the code less maintainable, so I don't
> think there is any point in doing it. In this case, we really do want to
> use scheduler functions, so the thing you do in that case is to include
> sched.h, not declare them yourself :(
> 
> If you are particularly concerned about this, just move all those refcount
> inlines into kernel/module.c (they're too big anyway)... then you can drop
> the sched.h include from module.h for free ;)

Agreed.  At least module_put should move out of line.
