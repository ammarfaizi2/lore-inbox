Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268713AbRGZWX2>; Thu, 26 Jul 2001 18:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268715AbRGZWXS>; Thu, 26 Jul 2001 18:23:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34066 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268713AbRGZWXJ>; Thu, 26 Jul 2001 18:23:09 -0400
Subject: Re: read() details
To: sim@netnation.com (Simon Kirby)
Date: Thu, 26 Jul 2001 23:24:28 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010726144719.A2098@netnation.com> from "Simon Kirby" at Jul 26, 2001 02:47:19 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PtYS-0004dn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Is it safe to assume that when a single read() call of x bytes a file
> (the file being locked against other processes appending to it) returns
> less than x bytes, the next read() will always return 0?  If so, is it

No. Posix allows any read to be interrupted. Unix doesn't do this. Even so
another writer in parallel on the same file will cause what you describe
