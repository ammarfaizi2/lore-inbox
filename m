Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUHaJ3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUHaJ3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUHaJ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:29:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:49156 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267592AbUHaJ3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:29:10 -0400
Date: Tue, 31 Aug 2004 10:29:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
Message-ID: <20040831102902.A19619@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040830204332.24da5615.akpm@osdl.org> <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408310411.i7V4B8Vs027772@magilla.sf.frob.com>; from roland@redhat.com on Mon, Aug 30, 2004 at 09:11:08PM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just about every architecture hasa line

+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)  ? 0x80 : 0));

you probably want a one-liner inline wrapper with a descriptive name
around this

