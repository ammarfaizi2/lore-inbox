Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVAQQNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVAQQNt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVAQQNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:13:49 -0500
Received: from [213.146.154.40] ([213.146.154.40]:61657 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261934AbVAQQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:13:47 -0500
Date: Mon, 17 Jan 2005 16:13:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robert Wisniewski <bob@watson.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       karim@opersys.com, hch@infradead.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050117161335.GA9404@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robert Wisniewski <bob@watson.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, karim@opersys.com,
	tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20050114002352.5a038710.akpm@osdl.org> <1105740276.8604.83.camel@tglx.tec.linutronix.de> <41E85123.7080005@opersys.com> <20050116162127.GC26144@infradead.org> <41EAC560.30202@opersys.com> <16874.50688.68959.36156@kix.watson.ibm.com> <20050116123212.1b22495b.akpm@osdl.org> <16874.54187.919814.272833@kix.watson.ibm.com> <1105911624.8734.55.camel@laptopd505.fenrus.org> <16875.56543.264481.586616@kix.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16875.56543.264481.586616@kix.watson.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 10:48:52AM -0500, Robert Wisniewski wrote:
> Wow - disabling interrupts is handfuls to tens of cycles, so that means
> some architectures take thousands of cycles to do atomic operations.  Then
> I would definitely agree we should not be using atomic operations on those,
> fwiw, out of curiosity, what archs make atomic ops so expensive.
> 
> Andrew, on the broader note.  If the community feels disabling interrupts
> is the better way to go for the variables (I think it's index and count) we
> were protecting with atomic ops then as the code stands things should be
> fine with that approach and we can make that change.

The thing I'm unhappy with is what the code does currently.  I haven't
looked at the code enough nor through about the problem enough to tell
you what's the right thing to do.  Knowing that will involve review of
the architecture and serious benchmarking on a few plattforms.

