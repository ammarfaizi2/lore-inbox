Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbTCZNDm>; Wed, 26 Mar 2003 08:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbTCZNDm>; Wed, 26 Mar 2003 08:03:42 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:57074 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261668AbTCZNDl>;
	Wed, 26 Mar 2003 08:03:41 -0500
Subject: Re: Framebuffer updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Florin Iucha <florin@iucha.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303252049550.6228-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048684571.10476.40.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Mar 2003 14:16:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 21:50, James Simmons wrote:

> Try using stty. I see most people will continue to use fbset so I guess I 
> need to patch it up to do the right thing.

Well, I don't like the fbdev magially picking modes like this,
those modes may just not be supported by the display. At least,
fbset allows me to setup the proper timings for 'special'
displays like iMac fixed hoziontal frequency for example.

Ultimately, we really need a "monitor" driver on top of the
fbdev that does DDC/EDID when the low level fbdev can provide
an i2c bus or EDID information via some different way and
that can be tweaked to deal with special monitors when we
know we are using these.

Ben.
