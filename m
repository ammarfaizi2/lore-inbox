Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUIETxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUIETxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 15:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267176AbUIETxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 15:53:14 -0400
Received: from web51105.mail.yahoo.com ([206.190.38.147]:41328 "HELO
	web51105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267170AbUIETxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 15:53:11 -0400
Message-ID: <20040905195310.60256.qmail@web51105.mail.yahoo.com>
Date: Mon, 6 Sep 2004 05:53:10 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: nbd questions and problems
To: Paul Clements <paul.clements@steeleye.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <413B40B3.1040009@steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Paul Clements <paul.clements@steeleye.com> wrote:

>  > It seems fine, but when the system touch swap
> there are error in the
>  > kernel log
>  >
>  > nbd0 Receive control failed result -104
>  >
>  > and the server exited .
> 
> Well, -104 is Connection reset by peer. Nothing in
> nbd would cause that 
> directly. Without seeing the error messages from the
> nbd-server it's 
> hard to tell, but I suspect that either nbd-server
> is dying at startup 

Nope, when I start the server it is running (waiting
for communication. When the client connect it is still
running (it print some thing like begin loop
request..). It only exited to the bash prompt without
any message. The syslog has a message (just found it)

nbd_server[16808]: Request too big!

probably is the reason why the server exited.

> (check the syslog on the server, a common cause is
> failure to open the 
> file/partition) or you have some sort of networking
> issue. Can you 
> otherwise communicate between the two systems over a
> TCP connection ?

I am sure the file is ok ; the communication is ok. As
later I succesfully ran enbd reliably (only with
2.4.27 in client, the 2.6.7 OOPs) so we can confirm
the TCP is good AFAIK enbd uses the same protocol. Can
ssh between the two machine, can http (run web browser
in client and access a page served by the server box
vise versa).

I will do more testing today. I need 2.6.8 kernel in
the client.

Kind regards,



=====
S.KIEU

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
