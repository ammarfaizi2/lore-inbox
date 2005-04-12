Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVDLFrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVDLFrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVDLFqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:46:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:45007 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262022AbVDLFem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:34:42 -0400
Date: Mon, 11 Apr 2005 22:34:15 -0700
From: Greg KH <greg@kroah.com>
To: Alex Aizman <itn780@yahoo.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 2/6] Linux-iSCSI High-Performance Initiator
Message-ID: <20050412053415.GD32372@kroah.com>
References: <425B3F58.2040000@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425B3F58.2040000@yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +struct iscsi_hdr {
> +	uint8_t		opcode;
> +	uint8_t		flags;		/* Final bit */
> +	uint8_t		rsvd2[2];
> +	uint8_t		hlength;	/* AHSs total length */
> +	uint8_t		dlength[3];	/* Data length */
> +	uint8_t		lun[8];
> +	uint32_t	itt;		/* Initiator Task Tag */
> +	uint32_t	ttt;		/* Target Task Tag */
> +	uint32_t	statsn;
> +	uint32_t	exp_statsn;
> +	uint8_t		other[16];

Please use u8 and u32 instead of the types you used here.  See the lkml
archives for many threads about this topic.

thanks,

greg k-h
