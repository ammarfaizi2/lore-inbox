Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266685AbUFWViH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266685AbUFWViH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUFWViH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:38:07 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:32264 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266684AbUFWVgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:36:31 -0400
Date: Wed, 23 Jun 2004 23:36:29 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.7-mm1] MBR centralization
Message-ID: <20040623213629.GC3072@pclin040.win.tue.nl>
References: <1088025348.2213.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088025348.2213.32.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 11:15:49PM +0200, FabF wrote:
> 
> 	-DOS_EXTENDED_PARTITION washing#2
> 		(we don't want magic numbers, do we ?)
> 		-Remove use of <= 4 to < DOS_EXTENDED_PARTITION where needed

> -       for (slot = 1; slot <= 4; slot++, p++) {
> +       for (slot = 1; slot < DOS_EXTENDED_PARTITION; slot++, p++) {

Maybe you do not know, but the 5 of DOS_EXTENDED_PARTITION is the
value written in the sys_ind field of a partition.

It is totally unrelated to the 4 that is the upper bound of the
loop over the four primary partitions in a DOS-type partition table.
