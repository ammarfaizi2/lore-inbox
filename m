Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVCFWp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVCFWp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCFWpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:45:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261585AbVCFWoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:44:21 -0500
Date: Sun, 6 Mar 2005 22:44:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/29] FAT: Remove the multiple MSDOS_SB() call
Message-ID: <20050306224418.GB5827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <87wtsmorii.fsf_-_@devron.myhome.or.jp> <87sm3aorho.fsf_-_@devron.myhome.or.jp> <87oedyorgu.fsf_-_@devron.myhome.or.jp> <87k6olq60a.fsf_-_@devron.myhome.or.jp> <87fyz9q5z7.fsf_-_@devron.myhome.or.jp> <87br9xq5y8.fsf_-_@devron.myhome.or.jp> <877jklq5x7.fsf_-_@devron.myhome.or.jp> <873bv9q5vx.fsf_-_@devron.myhome.or.jp> <87y8d1orah.fsf_-_@devron.myhome.or.jp> <87u0npor9o.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0npor9o.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 03:56:51AM +0900, OGAWA Hirofumi wrote:
> 
> Since MSDOS_SB() is inline function, it increases text size at each calls.
> I don't know whether there is __attribute__ for avoiding this.

If you mark it pure the compile should be smart enough to optimize way
multiple invocations - heck for an inline it should be smart enough without
annotaitons..

Anyway, your new version looks much more readable.

