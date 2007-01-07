Return-Path: <linux-kernel-owner+w=401wt.eu-S932477AbXAGK3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbXAGK3J (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXAGK3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:29:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60211 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbXAGK3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:29:07 -0500
Date: Sun, 7 Jan 2007 10:28:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Willy Tarreau <w@1wt.eu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
Message-ID: <20070107102853.GB26849@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
References: <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com> <20070107090336.GA7741@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107090336.GA7741@1wt.eu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 10:03:36AM +0100, Willy Tarreau wrote:
> The problem is that I have no sufficient FS knowledge to argument why
> it helps here. It was a desperate attempt to fix the problem for us
> and it definitely worked well.

XFS does rather efficient btree directories, and it does sophisticated
readahead for directories.  I suspect that's what is helping you there.

