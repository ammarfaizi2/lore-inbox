Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286157AbRLTGNb>; Thu, 20 Dec 2001 01:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286158AbRLTGNW>; Thu, 20 Dec 2001 01:13:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64131 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286157AbRLTGNJ>;
	Thu, 20 Dec 2001 01:13:09 -0500
Date: Wed, 19 Dec 2001 22:12:45 -0800 (PST)
Message-Id: <20011219.221245.02301926.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, cs@zip.com.au, billh@tierra.ucsd.edu,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220010742.A4254@redhat.com>
In-Reply-To: <20011220005928.F3682@redhat.com>
	<20011219.220247.101870714.davem@redhat.com>
	<20011220010742.A4254@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Thu, 20 Dec 2001 01:07:42 -0500
   
   1 process.  1 cpu machine.  1 gige card.  As much ram as you want.  No 
   syscalls.  Must exhibit a load curve similar to:
   
   	y
   	|  ...............
   	| .
   	|.
   	+----------------x
   
   Where x == requests per second sent to the machine and y is the number 
   of resposes per second sent out of the machine.  Hint: read the phttpd 
   and /dev/poll papers for an idea of the breakdown that happens for larger 
   values of x (make the cpu slower to cause the interesting points to move 
   lower).  For a third dimension to the graph, make the number of total 
   connections the z axis.

Ok, TUX can do it.  Now list for me some server that really matters
other than web and ftp?  If you say databases, then I agree with you
but I will also reiterate how the people who need that level of
database performance is "nook and cranny".

I think there is nothing wrong with doing a TUX module for situations
where 1) the server is important for enough people and 2) scaling to
the levels you are talking about is a real issue for that service.
