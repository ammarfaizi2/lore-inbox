Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWDMVUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWDMVUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWDMVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:20:43 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:27155 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S964977AbWDMVUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:20:42 -0400
Message-ID: <443EC09C.2050409@stud.feec.vutbr.cz>
Date: Thu, 13 Apr 2006 23:20:28 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: select takes too much time
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com> <443E9A17.4070805@stud.feec.vutbr.cz> <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com> <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (0.6 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -0.1 BAYES_20               BODY: Bayesian spam probability is 20 to 30%
                              [score: 0.2046]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> It is as though the sleep time is always at least 1000
> microseconds. If this is correct, then there should be some kind of
> warning that the time can't be less than the HZ value, or whatever is
> limiting it.

Of course you can't get lower resolution than 1/HZ, unless you're using 
a kernel with high-res timers. It's always been like that.
But it's not Ram's problem, because he's requesting a timeout of 90ms, 
which is much longer than one tick even with HZ=100.

Michal
