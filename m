Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUH0OVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUH0OVX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUH0OVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:21:22 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:57098 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265275AbUH0OVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:21:15 -0400
Date: Fri, 27 Aug 2004 15:21:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: drm fixup 1/2 - missing bus_address assignment
Message-ID: <20040827152110.A31641@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408271510530.32411@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408271510530.32411@skynet>; from airlied@linux.ie on Fri, Aug 27, 2004 at 03:12:30PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 03:12:30PM +0100, Dave Airlie wrote:
> +			buf->bus_address = virt_to_bus(buf->address);

this iw wrong.  never use virt_to_bus in new code and whenever you see it
in old code get rid of it.

