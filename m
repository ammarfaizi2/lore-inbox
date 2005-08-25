Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVHYJI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVHYJI7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 05:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVHYJI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 05:08:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20442 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964889AbVHYJI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 05:08:57 -0400
Date: Thu, 25 Aug 2005 10:08:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to atomic_t
Message-ID: <20050825090854.GA9740@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Dumazet <dada1@cosmosbay.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050824214610.GA3675@localhost.localdomain> <1124956563.3222.8.camel@laptopd505.fenrus.org> <430D8518.8020502@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430D8518.8020502@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 10:45:12AM +0200, Eric Dumazet wrote:
> This patch assumes that atomic_read() is a plain {return v->counter;} on 
> all architectures. (keywords : sysctl, /proc/sys/fs/file-nr, proc_dointvec)

But that's not true.  You need to write you own sysctl handler for it,
probably worth adding a generic atomic_t sysctl handler while you're
at it.

