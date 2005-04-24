Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVDXUSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVDXUSg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVDXUSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:18:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37770 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262398AbVDXUS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:18:26 -0400
Date: Sun, 24 Apr 2005 21:18:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424201820.GA28428@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <E1DPnOn-0000T0-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DPnOn-0000T0-00@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:08:13PM +0200, Miklos Szeredi wrote:
> This simple patch adds support for private (or invisible) mounts.  The
> rationale is to allow mounts to be private for a user but still in the
> global namespace.

As mentioned in the last -fsdevel thread a few times the idea of per-user
mounts is fundamentally flawed.  Crossing a namespace boundary must be
explicit - using clone or a new unshare() syscall.

