Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUH1KVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUH1KVs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUH1KVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:21:47 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:23819 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266705AbUH1KVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 06:21:17 -0400
Date: Sat, 28 Aug 2004 11:21:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4][diskdump] x86-64 support
Message-ID: <20040828112113.A8000@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <89C48CE36A27FFindou.takao@soft.fujitsu.com> <8BC48CE3D11D2Bindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8BC48CE3D11D2Bindou.takao@soft.fujitsu.com>; from indou.takao@soft.fujitsu.com on Sat, Aug 28, 2004 at 06:45:56PM +0900
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 06:45:56PM +0900, Takao Indoh wrote:
> This is a patch for scsi common layer.

still broken.  files that are not part of scsi_mod _must_ not include
scsi_priv.h.  You're still redefining SCSI_DATA_* instead of using the proper
constants directly. scsi_dump_probe still makes too many assumptions, the
selection must be entirely inside the scsi layer.

