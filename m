Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319549AbSIMIAj>; Fri, 13 Sep 2002 04:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319550AbSIMIAj>; Fri, 13 Sep 2002 04:00:39 -0400
Received: from denise.shiny.it ([194.20.232.1]:6302 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S319549AbSIMIAi>;
	Fri, 13 Sep 2002 04:00:38 -0400
Message-ID: <XFMail.20020913100519.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <OFDB91827C.152E85A4-ON88256C32.0067C0A4@boulder.ibm.com>
Date: Fri, 13 Sep 2002 10:05:19 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Jim Sibley <jlsibley@us.ibm.com>
Subject: RE: Killing/balancing processes when overcommited
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org,
       Thunder from the hill <thunder@lightweight.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I still favor an installation file in /etc specifying the order in which
> things are to be killed. Any alogrithmic assumptions are bound to fail at
> some point to the dissatisfaction of the installation.

I agree, I don't see any other solution. btw the thing is not
simple. The oom killer should be able to comply instructions
like:

if (oom)
  kill netscape if it uses more than 80MB {stdprio 10}
  //sometimes if start sucking memory endlessly
  kill make and its childs if overall they use {stdprio 7}
  more than ...[cpu files memory]
  //ever tried to make -j bzImage on a 64MB box ?
  kill httpd if it's swapping too much {stdprio 3}
  ...


Well, it's not simple. It must be planned carefully, or it
will and up being as uneffective as the current killer is.


Bye.

