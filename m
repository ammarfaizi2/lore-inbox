Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274293AbRITDDv>; Wed, 19 Sep 2001 23:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274296AbRITDDm>; Wed, 19 Sep 2001 23:03:42 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:57848 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274293AbRITDD0>; Wed, 19 Sep 2001 23:03:26 -0400
Message-ID: <3BA95C87.5272E764@kegel.com>
Date: Wed, 19 Sep 2001 20:03:35 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919192804.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more question: if I guess wrong initially about how many
file descriptors I'll be monitoring with /dev/epoll, and I need
to increase the size of the area inside /dev/epoll in the middle of
my scan through the results, what is the proper sequence of calls?

Some possibilities:

1)  EP_ALLOC, and continue scanning through the results

2)  EP_FREE, EP_ALLOC, EP_POLL because old results are now invalid

3)  EP_FREE, EP_ALLOC, write new copies of all the old fds to /dev/epoll, 
    EP_POLL, and start new scan

I bet it's #3.  Am I right?
- Dan
