Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUGGNJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUGGNJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUGGNJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 09:09:38 -0400
Received: from [213.146.154.40] ([213.146.154.40]:51081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265104AbUGGNI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 09:08:57 -0400
Date: Wed, 7 Jul 2004 14:08:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: Re: [5/9] Lustre VFS patches for 2.6
Message-ID: <20040707130856.GA18243@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@clusterfs.com>, linux-kernel@vger.kernel.org,
	braam@clusterfs.com
References: <20040707124733.GA25943@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707124733.GA25943@clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 03:47:33PM +0300, Oleg Drokin wrote:
> Exports
> 
>  fs/jbd/journal.c   |    1 +
>  fs/super.c         |    2 ++
>  include/linux/fs.h |    1 +
>  include/linux/mm.h |    3 +++
>  mm/truncate.c      |    4 +++-
>  5 files changed, 10 insertions(+), 1 deletion(-)

truncate_complete is still the wrong level of API to export, see the
last round of experts.  Maybe you should also talk to the reiser4 folks,
they want something similar.
