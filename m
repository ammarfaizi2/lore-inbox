Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274798AbRIUTrj>; Fri, 21 Sep 2001 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274799AbRIUTr3>; Fri, 21 Sep 2001 15:47:29 -0400
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:28899 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274798AbRIUTrS>;
	Fri, 21 Sep 2001 15:47:18 -0400
X-Sent: 21 Sep 2001 19:47:36 GMT
Message-ID: <3BAB9790.8DB400C@distributopia.com>
Date: Fri, 21 Sep 2001 14:40:00 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010921114539.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> Instead of requesting /dev/epoll changes to make it
> something that is not born for, i think that the /dev/poll
> patch can be improved in a significant way.
>

 I think there's agreement that Davide doesn't want
to change his /dev/epoll code.

 So, as an experiment, I'm modifying /dev/epoll to
more closely match the interface described in:

  http://citeseer.nj.nec.com/banga99measuring.html

 The paper describes in detail an event based
notification mechanism for determining which fd's are
ready for processing. Linux-/dev/poll is, and 
/dev/epoll appears to be, a variant of the mechanism
described in the paper.

 To save further pointless argument, I'm calling the
experiment "/dev/yapoll". 

 Specifically, I've added code to return the initial
state of the fd's as they are added to the interest
list. It seems to work ok so far, but I'll be doing
some benchmarking this weekend. I will post a patch
if no problems turn up.

 Davide seems to think it would be better to start
with the Linux-/dev/poll patch, but I disagree
(/dev/epoll itself appears to be based on the
Linux-/dev/poll code) I guess I'll soon find out if
he was right.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
