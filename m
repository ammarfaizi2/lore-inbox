Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273507AbRI3NYh>; Sun, 30 Sep 2001 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273505AbRI3NY2>; Sun, 30 Sep 2001 09:24:28 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:43619 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S273506AbRI3NYR>; Sun, 30 Sep 2001 09:24:17 -0400
Posted-Date: Sun, 30 Sep 2001 10:40:00 GMT
Date: Sun, 30 Sep 2001 11:40:00 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Networking <linux-net@vger.kernel.org>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0109301117130.4260-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik.

>>> sorry :-) definitions of netconsole-terms:
>>>
>>> 'server': the host that is the source of the messages. Ie. the box that
>>>           runs the netconsole.o module. It serves log messages to the
>>>           client.
>>>
>>> 'client': the host that receives the messages. This box is running the
>>>           netconsole-client.c program.

>> Servers is usually the thing waiting for something to be sent to it,
>> the client is the sending part(initiator). this works for web
>> servers, X servers, log servers but strangley not for netconsole
>> where everything is backwards.

> Owww crap.  The majority of web traffic is _from_ the server _to_
> the client. Same for ftp, realaudio, etc...

> In fact, usually the server is the _remote_ machine and the client
> is the _local_ machine.

There's actually one example in the email you were replying to where the
server is the local machine and the client is the remote one, which you
must have overlooked: X-Windows defines the server as being the machine
with the display that it is to draw its picture on.

Perhaps I can offer a more reasonable definition than yours, and one
that is offered by most UK universities:

    SERVER	The system with some facility which other systems
		wish to make use of.

    CLIENT	The system wishing to make use of some facility on
		the server.

Apply that to the relevant protocols and you get the following table:

	PROTOCOL	SERVER		CLIENT

	Login - CHAP	Local		Remote
	Login - PAP	Local		Remote
	Login - SSH	Local		Remote
	Login - Text	Remote		Local

	FTP		Remote		Local
	LogServer	Remote		Local
	PrintServer	Remote		Local
	RealAudio	Remote		Local
	Web		Remote		Local

	X-Windows	Local		Remote

	NetConsole	???		???

Note that under that definition, the server can be either the local or
the remote system, with a 3:2 bias towards it being the remote system. I
don't know NetConsole, so can't comment on how it uses them.

Also note that for one task (logging in) that can be done by four
different methods (that I am aware of), only one of those methods has
the server as the remote system. The CHAP, PAP and SSH login systems all
define the local machine (the one trying to log in) as being the one
having the private part of a public/private keypair, with both systems
having the public part, and therefore assume that the local system is
the server that will authenticate a message sent by the remote client to
verify that the server is the correct system and user. Only the text
login assumes the opposite.

> Anybody who believes in having the client remote and the server
> local should be shipped off to whereever the server is ;)

>From their point of view, they already are where the server is, so no
shipping is necessary.

Best wishes from Riley.

