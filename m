Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262149AbTCHTdA>; Sat, 8 Mar 2003 14:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbTCHTdA>; Sat, 8 Mar 2003 14:33:00 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:15372 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262149AbTCHTc7>; Sat, 8 Mar 2003 14:32:59 -0500
Date: Sat, 8 Mar 2003 19:43:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308194331.A31291@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Andries.Brouwer@cwi.nl,
	alan@lxorguk.ukuu.org.uk, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308005333.GF23071@kroah.com> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030308192908.GB26374@kroah.com>; from greg@kroah.com on Sat, Mar 08, 2003 at 11:29:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 11:29:08AM -0800, Greg KH wrote:
> I agree, I thought this was a 2.7 change, but it's looking like people
> want this change sooner :)

So people should have started working on it sooner.  If people really think
they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
that argument) we should just introduce it and use it only for block devices
(which already are fixed up for this) and stay with the old 8+8 split for
character devices.  Note that Linux is about doing stuff right, not fast.

