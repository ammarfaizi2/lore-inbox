Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTIPONU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 10:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTIPONU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 10:13:20 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:59016 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261899AbTIPONT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 10:13:19 -0400
X-Sender-Authentication: net64
Date: Tue, 16 Sep 2003 16:13:17 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: root@chaos.analogic.com
Cc: marcelo.tosatti@cyclades.com.br, neilb@cse.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
Message-Id: <20030916161317.7b295719.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53.0309160948460.27601@chaos>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
	<Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
	<20030916153658.3081af6c.skraw@ithnet.com>
	<Pine.LNX.4.53.0309160948460.27601@chaos>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Sep 2003 09:55:36 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> Can you explain what you mean by "network connections go bogus".

Sure. Do this:

Use a controller (like 3ware) that cannot DMA beyond a 4 GB range. Now put some
GBs of data onto that and start to tar the data around on the same disk. While
doing this you can watch network go crazy and drop packets at will. You can of
course force the whole setup further by (trying) additional nfs-action, but
this is really not needed.
Just about the same thing can be experienced if you do a simple find all over
the disk. CPU load explodes and network is _dead_.
To try this you need some GBs of data, a box with more than 4 GB ram, 3ware
controller and a usual SuSE 8.2. Wait until after midnight for "updatedb" to
run and try to login during that time ;-)
"Works" with out-of-the-box equipment and distro :-)

Regards,
Stephan
