Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbRFGQRQ>; Thu, 7 Jun 2001 12:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbRFGQRH>; Thu, 7 Jun 2001 12:17:07 -0400
Received: from felix.convergence.de ([212.84.236.131]:12947 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S261840AbRFGQQx>;
	Thu, 7 Jun 2001 12:16:53 -0400
Date: Thu, 7 Jun 2001 18:17:01 +0200
From: Felix von Leitner <leitner@convergence.de>
To: linux-kernel@vger.kernel.org
Subject: ipv6: can't connect to myself?!
Message-ID: <20010607181701.A3845@convergence.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't connect() to my own link-local address.
connect just hangs.

Before some wise guy now tells me I should be connecting to ::1 instead:
"oh, really!" ;)  The application is npush/npoll from my ncp program
suite, which can be found at http://www.fefe.de/ncp/.

Basically, the sender sends UDP announcements and the receiver connects
to the IP of the announcement on the interface of the announcement.

strace of the receiver reveals that it hangs in the connect() call.

Any takers?  Why does this not work?

Felix
