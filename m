Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbUB0MEh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUB0MEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:04:37 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:45828 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261798AbUB0MEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:04:35 -0500
Date: Fri, 27 Feb 2004 12:04:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227120433.A31544@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tim Bird <tim.bird@am.sony.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <403E4363.2070908@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <403E4363.2070908@am.sony.com>; from tim.bird@am.sony.com on Thu, Feb 26, 2004 at 11:05:07AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:05:07AM -0800, Tim Bird wrote:
> What's the rationale for not supporting interrupt priorities
> in the kernel?

What do you actually want to do them?  Linux doesn't do the traditional
unix spl scheme for coplexity and performance reasons, see

www.usenix.org/publications/library/proceedings/ana97/full_papers/small/small.ps

for a related paper.  Give that linux hardirq handlers should be very small
there's no performance gain in that area for sane architectures, too.

