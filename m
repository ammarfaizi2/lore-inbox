Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVJWWqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVJWWqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVJWWqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:46:46 -0400
Received: from [81.2.110.250] ([81.2.110.250]:18919 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750837AbVJWWqp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:46:45 -0400
Subject: Re: BUG in the block layer (partial reads not reported)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051023221204.GA20162@aitel.hist.no>
References: <Pine.LNX.4.44L0.0510201435400.4453-100000@iolanthe.rowland.org>
	 <1129915917.3542.7.camel@localhost.localdomain>
	 <20051023221204.GA20162@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Mon, 24 Oct 2005 00:14:43 +0100
Message-Id: <1130109283.15961.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-24 at 00:12 +0200, Helge Hafting wrote:
> Seems to me that the best fix for devices that may re�port the wrong size
> is to always use a foolproof way of determining the size.  I.e. when
> a CD-R cannot be trusted, determine the size by trying to read the
> last sectors instead of using the reported number.  

That may take up to half a minute on some CD drives that retry a lot
