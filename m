Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVDRIv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVDRIv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 04:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVDRIv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 04:51:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65231 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261960AbVDRIvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 04:51:25 -0400
Date: Mon, 18 Apr 2005 09:51:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Artem B. Bityuckiy" <dedekind@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
Subject: Re: [PATC] small VFS change for JFFS2
Message-ID: <20050418085121.GA19091@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Artem B. Bityuckiy" <dedekind@infradead.org>,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	dwmw2@lists.infradead.org
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113814031.31595.3.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:47:11PM +0400, Artem B. Bityuckiy wrote:
> JFFS2 assumes that the above mentioned 'state' field is always coherent
> with the real state of the inode. The state is changed on read_inode()
> and clear_inode() inode operation calls.
 
> One obvious thing to fix this JFFS2 problem is to acquire the iprune_sem
> semaphore in JFFS2 GC, but for this we need to export it. So, please,
> consider the following VFS patch (against Linux 2.6.11.5):

No, exporting locks is a really bad idea.  Please try to find a better
method to fix your problem that doesn't export random kernel symbols.

