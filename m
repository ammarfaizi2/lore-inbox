Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJAIqz>; Mon, 1 Oct 2001 04:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274777AbRJAIqf>; Mon, 1 Oct 2001 04:46:35 -0400
Received: from tangens.hometree.net ([212.34.181.34]:30662 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S274774AbRJAIqd>; Mon, 1 Oct 2001 04:46:33 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <mailgate@hometree.net>
Newsgroups: hometree.linux.kernel
Subject: Re: [patch] netconsole-2.4.10-B1
Date: Mon, 1 Oct 2001 08:47:00 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <9p9ai4$qgh$1@forge.intermeta.de>
In-Reply-To: <3BB693AC.6E2DB9F4@canit.se> <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1001926020 5209 212.34.181.4 (1 Oct 2001 08:47:00 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Mon, 1 Oct 2001 08:47:00 +0000 (UTC)
X-Copyright: (C) 1996-2001 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

>Owww crap.  The majority of web traffic is _from_ the
>server _to_ the client. Same for ftp, realaudio, etc...

Did you mean:

Server is the data source.
Client is the data sink.

netconsole.o is the server (data source)
netconsole listener is the client (data sink)

Or did you mean:

Server is the part that offers a service
Client is the part that uses the service

netconsole listener offers the "receive console messages" service -> server
netconsole.o uses the "receive console message" service -> client

So both definitions are right/wrong. Choose any you like. Just
document it and stick to it. =:-) 

I am happy to have a network console no matter what is the client and
what is the server.

I personally, would say, that if you have a "one - many" network
relation, then the "one" part is the server. So in this case, the
netconsole listener would be the server and the netconsole.o the
client(s). Which is like syslog and so conforms to the "principle of
least surprise". :-)

Or can you have multiple listeners to a single netconsole.o instance?

	Regards
		Henning

OT: "Client/Server computing is like teenage sex. Everyone talks about
it, almost nobody really does it and those who do, don't get it right
most of the time". :-)

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
