Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbTFWJjw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 05:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbTFWJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 05:39:52 -0400
Received: from angband.namesys.com ([212.16.7.85]:19098 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S265971AbTFWJjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 05:39:51 -0400
Date: Mon, 23 Jun 2003 13:53:56 +0400
From: Oleg Drokin <green@namesys.com>
To: Nix <nix@esperi.demon.co.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.4.21 reiserfs oops
Message-ID: <20030623095356.GA12936@namesys.com>
References: <87he6iyzyj.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87he6iyzyj.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Jun 22, 2003 at 03:00:20PM +0100, Nix wrote:

> Jun 22 13:52:42 loki kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000001 

This is very strange address to oops on.

> Jun 22 13:52:43 loki kernel: EIP:    0010:[<c0092df4>]    Not tainted 

And the EIP is prior to kernel start which is also very strange.
On the other hand the address c0192df4 is somewhere inside reiserfs code,
so it looks like a single bit error, I'd say.

Can you run memtest86 for some time to verify that your RAM is OK?
(hm, and the oops got twice to the logs which is pretty strange thing, too,
never seen anything like this).

Bye,
    Oleg
