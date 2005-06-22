Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVFVOeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFVOeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVFVOb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:31:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3815 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261351AbVFVO3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:29:51 -0400
Date: Wed, 22 Jun 2005 15:29:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
       Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050622142947.GA26993@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexander Zarochentsev <zam@namesys.com>,
	Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506221824.32995.zam@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 06:24:32PM +0400, Alexander Zarochentsev wrote:
> Reiser plugins are for the same.  Would you agree with reiser4 plugin design 
> if the plugins will not dispatch VFS object methods calls by themselves but 
> set ->foo_ops fileds instead?  I guess you don't like to have the two 
> dispatching systems at the same level.

That is exactly the point I want to make.  I haven't looked at the design
in detail for a long time, but schemes to allow different object to have
different operation vectors is a good idea.  We already have that to
varying degrees in all filesystems, and making that more formal is a good
thing.  
