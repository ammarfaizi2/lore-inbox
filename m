Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbTHTUqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTHTUqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:46:46 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57611 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262180AbTHTUqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:46:45 -0400
Date: Wed, 20 Aug 2003 21:46:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: posix_fallocate question again
Message-ID: <20030820214643.A5572@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
References: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41F331DBE1178346A6F30D7CF124B24B0183C1A4@fmsmsx409.fm.intel.com>; from kenneth.w.chen@intel.com on Wed, Aug 20, 2003 at 12:07:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 12:07:10PM -0700, Chen, Kenneth W wrote:
> This has been brought up by Ulrich more than 3 years ago:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=95569775802945&w=2

Note that the design for posix_fallocate is stupid.  We really want
a 64bit len argument even on 32bit machines.

> Is there anytime soon that kernel 2.6 will have such functionality?

On XFS you can use ioctl(.., XFS_IOC_RESVSP64, ..)

