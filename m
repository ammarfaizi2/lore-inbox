Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274351AbRIYBag>; Mon, 24 Sep 2001 21:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274347AbRIYBa0>; Mon, 24 Sep 2001 21:30:26 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:43494 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S274342AbRIYBaS>;
	Mon, 24 Sep 2001 21:30:18 -0400
Message-ID: <3BAFDE0D.8A69A993@sun.com>
Date: Mon, 24 Sep 2001 18:29:49 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: read() called twice for /proc files
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a general solution to the case of read() being called minimum
twice for a file in /proc?  I have a small file in /proc, whose data takes
a fair time to generate.  My read() handler gets called once for the data,
and once so I can return 0 to terminate read().

This results in the actual read taking twice as long.  Perhaps I am missing
something...

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
