Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270109AbTGUOfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270120AbTGUOfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:35:52 -0400
Received: from gsd.di.uminho.pt ([193.136.20.132]:16267 "EHLO
	bbb.lsd.di.uminho.pt") by vger.kernel.org with ESMTP
	id S270109AbTGUOfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:35:42 -0400
Date: Mon, 21 Jul 2003 15:50:42 +0100
From: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: SVR4 STREAMS (for example LiS)
Message-ID: <20030721145042.GA17555@lsd.di.uminho.pt>
Mail-Followup-To: Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt>,
	linux-kernel@vger.kernel.org
References: <3F1BF509.1000608@giga-stream.de> <Pine.LNX.4.53.0307211031460.18968@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307211031460.18968@chaos>
User-Agent: Mutt/1.4.1i
X-Disclaimer: 'Author of this message is not responsible for any harm done to reader's computer.'
X-Organization: 'GSD'
X-Section: 'BIC'
X-Priority: '1 (Highest)'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 10:38:38AM -0400, Richard B. Johnson wrote:
> Streams are an extension of buffered I/O implimented by the 'C'
> runtime library. Streams really have nothing to do with the
> internal workings of kernel I/O. As far as kernel I/O goes,
> one reads() and writes() from user-space.

Actually, SysV Streams do.

An ex, for openning a pty, on svr4:
fds = open(pts_name, O_RDWR)
ioctl(fds, I_PUSH, "ptem")
ioctl(fds, I_PUSH, "ldterm")
ioctl(fds, I_PUSH, "ttcompat")

Where ptem, ldterm, ttcompat work as independent modules converting the
stream, resulting in a pseudo-terminal implementation.

New programs should just use openpty directly, and let libc take care
of the actual implementation.

Also, BSD sockets were implemented using streams also, thus the compatibility
libraries.

Anyway, I see no point in caring wether streams are used or not in normal
programs.

Regards,
Luciano Rocha
