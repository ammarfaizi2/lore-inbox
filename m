Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbVAKOiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbVAKOiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVAKOit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:38:49 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:59921
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262784AbVAKOim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:38:42 -0500
Date: Tue, 11 Jan 2005 15:38:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-os@analogic.com
Cc: "Patrick J. LoPresti" <patl@curl.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random vs. /dev/urandom
Message-ID: <20050111143854.GO26799@dualathlon.random>
References: <20050107190536.GA14205@mtholyoke.edu> <20050107213943.GA6052@pclin040.win.tue.nl> <Pine.LNX.4.61.0501071729330.22391@chaos.analogic.com> <s5gzmzjbza1.fsf@egghead.curl.com> <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501100735210.19253@chaos.analogic.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 07:41:02AM -0500, linux-os wrote:
> one could AND with 0 and show that all randomness has been removed.

Zero removes all bits so it's a special case.

As long as 1 bit is left coming from /dev/*random and not your
application, you're guaranteed that single bit to be random (since you
didn't mask it).

It's like if I read 100 bytes from /dev/random and then I truncate the
last 99 and it'll be as random as reading a single byte. Random means
all single bits are random too, not only the entire bytes.
