Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbVIVEYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbVIVEYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVEYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:24:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:22480 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965225AbVIVEYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:24:54 -0400
Date: Thu, 22 Sep 2005 05:24:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ISDN USB build breakage
Message-ID: <20050922042445.GG7992@ftp.linux.org.uk>
References: <43322900.7050500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43322900.7050500@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 11:46:08PM -0400, Jeff Garzik wrote:
> 
> Latest -git tree 'make allmodconfig' build breaks on 32-bit x86:
> 
>   CC [M]  drivers/isdn/hisax/st5481_usb.o
> drivers/isdn/hisax/st5481_usb.c: In function `st5481_in_mode':
> drivers/isdn/hisax/st5481_usb.c:648: error: `URB_ASYNC_UNLINK' 
> undeclared (first use in this function)
> drivers/isdn/hisax/st5481_usb.c:648: error: (Each undeclared identifier 
> is reported only once
> drivers/isdn/hisax/st5481_usb.c:648: error: for each function it appears 
> in.)

Revert the last changeset touching drivers/isdn/hisax/st5481.h.
