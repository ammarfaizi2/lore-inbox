Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266159AbUFUIEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266159AbUFUIEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUFUICk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 04:02:40 -0400
Received: from [213.146.154.40] ([213.146.154.40]:2273 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266154AbUFUIC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 04:02:29 -0400
Date: Mon, 21 Jun 2004 09:02:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4]Diskdump Update
Message-ID: <20040621080224.GA15256@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>, arjanv@redhat.com,
	linux-kernel@vger.kernel.org
References: <1086954645.2731.23.camel@laptop.fenrus.com> <DBC45765BB709Eindou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBC45765BB709Eindou.takao@soft.fujitsu.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 04:59:52PM +0900, Takao Indoh wrote:
> >> int cmd, unsigned long param)
> >
> >
> >ehhh this looks evil
> 
> Do you mean I should use not ioctl but the following style?
> 
> echo "add /dev/hda1" > /proc/diskdump
> echo "delete /dev/hda1" > /proc/diskdump

the right interface would probably be a dump attribute for the scsi_device
where you can echo enable or disable (or 1/0) to.  The also nicely solves
then need to find an associated scsi_device for a given block_dev.
