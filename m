Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbRERUGp>; Fri, 18 May 2001 16:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbRERUGf>; Fri, 18 May 2001 16:06:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41743 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261516AbRERUGZ>; Fri, 18 May 2001 16:06:25 -0400
Subject: Re: Kernel bug with UNIX sockets not detecting other end gone?
To: Q@ping.be (Kurt Roeckx)
Date: Fri, 18 May 2001 21:02:51 +0100 (BST)
Cc: chris@scary.beasts.org (Chris Evans), linux-kernel@vger.kernel.org,
        davem@redhat.com
In-Reply-To: <20010518192422.B18162@ping.be> from "Kurt Roeckx" at May 18, 2001 07:24:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150qSZ-0007cw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I'm seeing however in an other program is that select says I
> can read from the socket, and that read returns 0, with errno set
> to EGAIN.  I call select() again, with returns and says I can read

No no no. If the read does not return -1 it does not change errno. EOF isnt
an error.


