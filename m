Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVJWWJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVJWWJw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVJWWJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:09:52 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:41370 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750781AbVJWWJv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:09:51 -0400
Date: Mon, 24 Oct 2005 00:12:04 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in the block layer (partial reads not reported)
Message-ID: <20051023221204.GA20162@aitel.hist.no>
References: <Pine.LNX.4.44L0.0510201435400.4453-100000@iolanthe.rowland.org> <1129915917.3542.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1129915917.3542.7.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 06:31:57PM +0100, Alan Cox wrote:
> 
> The essential problem however is that if you say a disc is a given size
> and it turns out not to be (as happens with CD-R especially or with
> buggy readers) then Linux block layer can't cope. Its well known and
> causes endless problems for CD-R users with some IDE drives on Linux.
> Its a big generator of 2.6 vendor bug reports.
> 
Seems to me that the best fix for devices that may re�port the wrong size
is to always use a foolproof way of determining the size.  I.e. when
a CD-R cannot be trusted, determine the size by trying to read the
last sectors instead of using the reported number.  

Helge Hafting
