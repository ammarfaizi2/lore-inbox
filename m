Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTHQNHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270003AbTHQNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:07:37 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:5651 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269981AbTHQNHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:07:37 -0400
Date: Sun, 17 Aug 2003 14:07:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dominik Strasser <Dominik.Strasser@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
Message-ID: <20030817140735.A11477@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dominik Strasser <Dominik.Strasser@t-online.de>,
	linux-kernel@vger.kernel.org
References: <3F3F782C.2030902@t-online.de> <20030817134633.A7881@infradead.org> <3F3F7E67.2040506@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3F7E67.2040506@t-online.de>; from Dominik.Strasser@t-online.de on Sun, Aug 17, 2003 at 03:08:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 03:08:55PM +0200, Dominik Strasser wrote:
> I am sorry, in 2.6.0-test3 (which I should have mentioned), there is no 
> u8 in liux/types.h.

u8 is defined in asm/types.h but the proper way to include asm/types.h
is through linux/types.h.

> Just a __u8.
> Nevertheless there is a mixture in scsi.h, some lines above, u_char is 
> used. This is why I chose to use it.

If you want consistency please convert all u_char to u8 (similar
for u_short -> u16 and u_int -> u32)

