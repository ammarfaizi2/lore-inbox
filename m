Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVF0JGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVF0JGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVF0JGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:06:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49810 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261960AbVF0JGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:06:42 -0400
Date: Mon, 27 Jun 2005 10:06:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, zam@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627090640.GA5410@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, zam@namesys.com,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:54:58PM -0700, Andrew Morton wrote:
> reiser4

So looking over the code a little for the plugin debate I found that a
reason patch introduces a ->put_inode method in reiser4.  We plan to
kill ->put_inode because it's the wrong abstraction and almost impossible
to use non-racy (reiser4 usage is racy).

I had a discussion with someone from namesys how to solve this correctly,
but I don't remember the details of either the solution or problem anymore.
Unless someone else does let's describe the problem again so we can find
a proper fix.
