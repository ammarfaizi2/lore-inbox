Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVADJ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVADJ0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 04:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVADJ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 04:26:18 -0500
Received: from [213.146.154.40] ([213.146.154.40]:45448 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261578AbVADJ0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 04:26:13 -0500
Date: Tue, 4 Jan 2005 09:26:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050104092612.GA2371@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103115120.GB18408@infradead.org> <20050104090408.GA12197@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104090408.GA12197@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 10:04:08AM +0100, Ingo Molnar wrote:
> or is it the addition of _smp_processor_id() as a way to signal 'this
> smp_processor_id() call in a preemptible region is fine, trust me'?

Yes.

> We
> could do smp_processor_id_preempt() or some other name - any better
> suggestions?

I'd just kill the debug check and rely on the eye of the review to not
let new users of smp_processor_id slip in.

