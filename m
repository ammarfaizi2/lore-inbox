Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTDUR6N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTDUR6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 13:58:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:11018 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261807AbTDUR6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 13:58:13 -0400
Date: Mon, 21 Apr 2003 19:10:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, "David S. Miller" <davem@redhat.com>,
       Andries.Brouwer@cwi.nl, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030421191013.A9655@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	"David S. Miller" <davem@redhat.com>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304211354280.12110-100000@serv> <Pine.LNX.4.44.0304211056210.3101-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304211056210.3101-100000@home.transmeta.com>; from torvalds@transmeta.com on Mon, Apr 21, 2003 at 11:01:21AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 11:01:21AM -0700, Linus Torvalds wrote:
> Oh, the split has huge meaning inside the kernel. We split the number 
> every time we open the device, and use that split to look up the result.

Not anymore for blockdevices.  And now that Al's back not anymore soon
for charater devices, too :)

Really, it's a bad idea to introduce this arbitrary split now that
the major/minor split is basically gone inkernel after lots of hard
work.
