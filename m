Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTETAfT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTETAfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:35:19 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:31903 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263364AbTETAfQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:35:16 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 19 May 2003 17:47:15 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: John Myers <jgmyers@netscape.com>, linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
In-Reply-To: <3EC9807D.3080804@kegel.com>
Message-ID: <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
 <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com>
 <3EC9807D.3080804@kegel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Dan Kegel wrote:

> Davide Libenzi wrote:
> > Adding a single shot feature to epoll takes about 5 lines of code,
> > comments included :) You know how many reuqests I had ? Zero, nada.
>
> I thought edge triggered epoll *was* single-shot.

For single shot I mean that once you receive one event, you will not
receive more events for that fd if you do not rearm it. Suppose you
receive 1000 bytes of data and you get an event (EPOLLIN). If after 10
seconds you receive another 1000 bytes, you will receive another event.
This is not single shot.


- Davide

