Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVB1DWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVB1DWm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 22:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVB1DWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 22:22:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34781 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261540AbVB1DW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 22:22:27 -0500
Date: Mon, 28 Feb 2005 03:22:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050228032220.GB5300@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Wen Xiong <wendyx@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com> <42226A3E.6000707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42226A3E.6000707@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 07:47:58PM -0500, Jeff Garzik wrote:
> >+struct shrink_buf_struct {
> >+	unsigned int	shrink_buf_vaddr;	/* Virtual address of board 
> >*/
> >+	unsigned int	shrink_buf_phys;	/* Physical address of board 
> >*/
> 
> Major bug.  These should be unsigned long.

not sure what they actually mean, but a virtual address should be
a void * and drivers shouldn't ever mess with physical addresses.

