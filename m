Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268963AbRHLHBK>; Sun, 12 Aug 2001 03:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268970AbRHLHBA>; Sun, 12 Aug 2001 03:01:00 -0400
Received: from www.wen-online.de ([212.223.88.39]:12298 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S268963AbRHLHAu>;
	Sun, 12 Aug 2001 03:00:50 -0400
Date: Sun, 12 Aug 2001 09:00:54 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Steve Kieu <haiquy@yahoo.com>
cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
In-Reply-To: <20010812001307.49534.qmail@web10406.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0108120754020.593-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Steve Kieu wrote:

> Anyone noticed that?

Details?

Here, disk write throughput seems to want some tweaking, and Bonnie
doing it's rewrite test triggers a very large and persistant inactive
shortage which shouldn't be there (imho).

page_launder() is definitely working better than some of the pre8
kernels in that it is no longer laundering the entire dirty list in
one huge gulp.  It is also no longer laundering some random amount.

Under FWIW:  I can find no reason for the existance of either the
launder_loop nor doing synchronous IO.  Here, I remove both regularly
and detect nothing but benefit both in responsivness and throughput.

	-Mike

