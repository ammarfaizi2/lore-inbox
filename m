Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUFVMMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUFVMMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 08:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUFVMMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 08:12:06 -0400
Received: from [213.146.154.40] ([213.146.154.40]:36996 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263003AbUFVMMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 08:12:02 -0400
Date: Tue, 22 Jun 2004 13:12:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4]Diskdump Update
Message-ID: <20040622121201.GA1820@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	linux-kernel@vger.kernel.org
References: <20040617133906.GA32219@infradead.org> <E3C45850AF4E78indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3C45850AF4E78indou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 09:01:43PM +0900, Takao Indoh wrote:
> On Thu, 17 Jun 2004 14:39:06 +0100, Christoph Hellwig wrote:
> 
> >> >please make it not a module of it's own but part of the
> >> >scsi code, 
> >> 
> >> Do you mean scsi_dump module should be merged with sd_mod.o or scsi_mod.o?
> >
> >scsi_mod.o.
> 
> It is difficult because disk_dump and scsi_dump try to check checksum of
> itself using check_crc_module so as to confirm whether module is
> compromised or not.


> Therefore, scsi_dump need to be always compiled as independent module.
> If scsi_dump is merged with scsi_mod, scsi_mod is not able to be
> compiled statically.

So check if it's a module and otherwise not.
