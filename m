Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUBLNxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 08:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUBLNxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 08:53:31 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:7182 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266428AbUBLNx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 08:53:29 -0500
Date: Thu, 12 Feb 2004 13:53:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Semaphore with timeout....
Message-ID: <20040212135328.A2434@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	RANDAZZO@ddc-web.com, linux-kernel@vger.kernel.org
References: <89760D3F308BD41183B000508BAFAC4104B16F65@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F65@DDCNYNTD>; from RANDAZZO@ddc-web.com on Thu, Feb 12, 2004 at 08:22:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 08:22:04AM -0500, RANDAZZO@ddc-web.com wrote:
> 
> In reference to loadable kernel modules... (drivers)
> 
> Is there a semaphore call that will either release with token or a specified
> amt of time....

There's no down_timeout.  Unfortunately - at least the qlogic fibrechannel
driver would love to have a primitive for that.

Look at drivers/scsi/qla2xxx/qla_os.c:qla2x00_down_timeout() for a horrible
hack to emulate one.

