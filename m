Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUFNSaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUFNSaW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 14:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUFNSaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 14:30:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263766AbUFNSaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 14:30:19 -0400
Date: Mon, 14 Jun 2004 19:30:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __user and iov_base
Message-ID: <20040614183017.GB12308@parcelfarce.linux.theplanet.co.uk>
References: <1087235597.10368.12.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087235597.10368.12.camel@stevef95.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 12:53:18PM -0500, Steve French wrote:
> If a buffer is never used in user space, and is potentially recycled
> (via mempools) for use by more than one process, then it can't be passed
> around as an __user buffer, but is it ok to simply do
> 	myiovec.iov_base = (__user char *)some_buffer; 
> or is there another preferred way to handle kernel to __user
> mappings/casts?

Yes - leave them alone.  The warning points to real problem with the
interface; ergo, it should not disappear until there's a clean solution
(if ever).
