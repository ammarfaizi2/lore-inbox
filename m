Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbTA0JjM>; Mon, 27 Jan 2003 04:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTA0JjM>; Mon, 27 Jan 2003 04:39:12 -0500
Received: from elin.scali.no ([62.70.89.10]:45061 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S266712AbTA0JjK>;
	Mon, 27 Jan 2003 04:39:10 -0500
Subject: Re: debate on 700 threads vs asynchronous code
From: Terje Eggestad <terje.eggestad@scali.com>
To: Lee Chin <leechin@mail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-newbie@vger.kernel.org
In-Reply-To: <20030123231913.26663.qmail@mail.com>
References: <20030123231913.26663.qmail@mail.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1043660902.21075.11.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 27 Jan 2003 10:48:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apart from the argument already given on other replies, you should
keep in mind that you probably need to give priority to doing receive.
THat include your clients, but if you don't you run into the risk of
significantly limiting your bandwidth since the send queues around your
system fill up. 

Try doing that with threads. 


Actually I would recommend the approach c)

c)  Write an asynchronous system with only 2 or three threads where I
manage the connections and keep the state of each connection in a data
structure.  


On fre, 2003-01-24 at 00:19, Lee Chin wrote:
> Hi
> I am discussing with a few people on different approaches to solving a scale problem I am having, and have gotten vastly different views
> 
> In a nutshell, as far as this debate is concerned, I can say I am writing a web server.
> 
> Now, to cater to 700 clients, I can
> a) launch 700 threads that each block on I/O to disk and to the client (in reading and writing on the socket)
> 
> OR
> 
> b) Write an asycnhrounous system with only 2 or three threads where I manage the connections and stack (via setcontext swapcontext etc), which is progromatically a little harder
> 
> Which way will yeild me better performance, considerng both approaches are implemented optimally?
> 
> Thanks
> Lee
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

