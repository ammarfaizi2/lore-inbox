Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270853AbTGPJ6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 05:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270854AbTGPJ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 05:58:46 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:61934 "EHLO gaston")
	by vger.kernel.org with ESMTP id S270853AbTGPJ6p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 05:58:45 -0400
Subject: Re: radeonfb and 32bit depth
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@angry-pixels.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030715060051.GA5738@darkwood>
References: <20030715060051.GA5738@darkwood>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Message-Id: <1058350410.515.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jul 2003 12:13:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 08:00, Jacek Pop³awski wrote:
> I was testing radeonfb in 2.4.22-pre6, my card is Sapphire 9100.
> 
> Everything works great in 8bit depth.
> 
> But when I use for example following mode:
> 
> mode "640x480-100@32"
> 	geometry 640 480 640 480 32
>         timings 22272 48 32 17 22 128 12
> endmode
> 
> cursor changes to black.

That's a known problem with fbdev core, the "fix" would be to
implement HW cursor support in radeonfb...

Ben.

