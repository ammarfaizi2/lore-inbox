Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTG1U2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTG1U22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:28:28 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:12556 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271042AbTG1U1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:27:08 -0400
Date: Mon, 28 Jul 2003 22:27:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030728202704.GA1815@win.tue.nl>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307281555400.27569@chaos>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 04:00:03PM -0400, Richard B. Johnson wrote:

> I have experimentally determined that I can turn off
> the automatic screen blanking with the following escape
> sequence.
> 
> const char blk[]={27, '[', '9', ';', '0', ']', 0};
> main()
> {
>     printf(blk);
> }
> 
> I need to know what the appropriate ioctl() is to do this

The variable blankinterval is static in console.c.
No, no ioctl, just the escape sequence. (2.4.21)

