Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266523AbRGYOOv>; Wed, 25 Jul 2001 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266723AbRGYOOl>; Wed, 25 Jul 2001 10:14:41 -0400
Received: from [62.254.209.2] ([62.254.209.2]:47352 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S266523AbRGYOOY>;
	Wed, 25 Jul 2001 10:14:24 -0400
Date: Wed, 25 Jul 2001 15:14:28 +0100 (BST)
From: Stephen Landamore <stephenl@zeus.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Select with device and stdin not working
Message-ID: <Pine.LNX.4.10.10107251505060.2829-100000@phaedra.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *15PPQi-0008Sr-00*6WQ3JFlakS6* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Select is working fine for device (in this example /dev/random) or
> stdin. But for both, not. When entering something to stdin, it's not
> sure select will return.

If stdin is a tty, chances are select will not show any data ready
until you hit return - this is canonical mode (or cooked mode).  Try
clearing canonical mode (or setting cbreak / raw mode).

In the case of stdin being a tty, and you are typing away, note that
your keypresses will generate entropy - so /dev/random probably will
become ready to read before stdin ;)

cheers,
stephen

--
Stephen Landamore, <slandamore@zeus.com>              Zeus Technology
Tel: +44 1223 525000                      Universally Serving the Net
Fax: +44 1223 525100                              http://www.zeus.com
Zeus Technology, Zeus House, Cowley Road, Cambridge, CB4 0ZT, ENGLAND

