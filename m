Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbSKVBLd>; Thu, 21 Nov 2002 20:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSKVBLd>; Thu, 21 Nov 2002 20:11:33 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:57348 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267259AbSKVBLc>; Thu, 21 Nov 2002 20:11:32 -0500
Date: Fri, 22 Nov 2002 01:18:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill i_dev
Message-ID: <20021122011839.A18100@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200211212346.gALNkem21004.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0211211548530.5779-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211211548530.5779-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 21, 2002 at 03:56:23PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not convinced that returning random numbers to user space is
> necessarily a great idea.. That said, I think we already do it for unnamed
> pipes anyway, so I'm more wondering if we should have some way to map
> these numbews (in user space) to a valid thing, so that they wouldn't just
> be random numbers.

That just means someone has to implement a trivial ->getattr wrapper for
sockfs that zeroes out the st_dev field.

