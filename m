Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUFIXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUFIXXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUFIXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:23:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:48352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265891AbUFIXXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:23:03 -0400
Date: Wed, 9 Jun 2004 16:25:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Clint Byrum <cbyrum@spamaps.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vm/elevator loading down disks where 2.4 does not
Message-Id: <20040609162548.63d69b78.akpm@osdl.org>
In-Reply-To: <1086724300.5467.161.camel@localhost>
References: <1086724300.5467.161.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clint Byrum <cbyrum@spamaps.org> wrote:
>
> When we upgraded one of our production boxes (details below) to 2.6.6,
> we noticed an immediate loss of 5 - 15 percent efficiency. While these
> boxes usually had less than 0.5% variation through out the day, this box
> was consistently doing 10% fewer searches than the others.
> 
> Upon investigation, we saw that the 2.6 box was reading from the disk
> about 5 times as much as 2.4. Iin 2.4 we can almost completely saturate
> the CPUs; they'll get to 90% of the real CPU's, and 15% of the virtual
> CPUs. With 2.6, they never get above 60/10 because they are in io-wait
> state constantly (which, under 2.4, is reported as idle IIRC).

Possibly a memory zone problem.  Could you try booting with "mem=896m" on
the kernel command line, see how that affects things?
