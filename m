Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVGMOil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVGMOil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbVGMOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:38:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:28812 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262667AbVGMOh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:37:57 -0400
Date: Wed, 13 Jul 2005 15:37:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Olaf Hering <olh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Message-ID: <20050713143742.GB26025@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>,
	"Moore, Eric Dean" <Eric.Moore@lsil.com>, Olaf Hering <olh@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org
References: <91888D455306F94EBD4D168954A9457C030A908F@nacos172.co.lsil.com> <20050713021648.GA23118@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713021648.GA23118@lists.us.dell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In general, this construct:
> 
> > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > -{
> > > -	return sdev->online;
> > > -}
> > > -#endif
> 
> is better tested as:
> 
> #ifndef scsi_device_inline
> static int inline scsi_device_online(struct scsi_device *sdev)
> {
>     return sdev->online;
> }
> #endif

Even better fusion should stop using this function because doing so
is broken.. We tried that long ago but it got stuck somewhere.

