Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTIATEM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTIATEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:04:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:24961 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263190AbTIATEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:04:09 -0400
Date: Mon, 1 Sep 2003 12:04:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dale E Martin" <dmartin@cliftonlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more
 details)
Message-Id: <20030901120412.2047eeff.akpm@osdl.org>
In-Reply-To: <20030901182359.GA871@cliftonlabs.com>
References: <20030901153305.GA1429@cliftonlabs.com>
	<20030901182359.GA871@cliftonlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dale E Martin" <dmartin@cliftonlabs.com> wrote:
>
> I just removed TCQ from my IDE setup, and I still lock up during boot.  The
> last message displayed is:
> mice: PS/2 mouse device common for all mice
> 
> The numlock comes on, and then I'm locked up hard, for instance, I cannot
> turn off the numlock at this point.
> 
> One thing that I would note is that I don't have anything plugged into my
> PS2/2 port since I have a USB mouse.  (A Kensington Model# MOSUU B, that
> works fine in 2.4.x, FWIW.)  Please advise if there is more debugging that
> I can try.

Are you able to plug any PS/2 devices into the machine, see if that makes a
difference?

Also it would be useful to add the option "initcall_debug" to the kernel
boot command line.  Then you will see a bunch of messages of the form

	calling initcall 0xNNNNNNNN

Please look up the final address in the System.map file from the 2.6 build.
This will give us an idea of what the machine was trying to do when it
died.



