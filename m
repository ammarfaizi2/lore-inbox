Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132624AbRC1X4r>; Wed, 28 Mar 2001 18:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRC1X4h>; Wed, 28 Mar 2001 18:56:37 -0500
Received: from rmx441-mta.mail.com ([165.251.48.44]:20204 "EHLO
	rmx441-mta.mail.com") by vger.kernel.org with ESMTP
	id <S132627AbRC1X4U>; Wed, 28 Mar 2001 18:56:20 -0500
Message-ID: <382729285.985823739747.JavaMail.root@web584-mc>
Date: Wed, 28 Mar 2001 18:55:39 -0500 (EST)
From: Lee Chin <leechin@mail.com>
To: William T Wilson <fluffy@snurgle.org>
Subject: Re: FWD: 3 NIC cards problem
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 63.206.124.79
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks!!! That worked.  Now I have one more problem... I am using non
blcking sockets (set via fcntl).

And I am using select (with a 20 second timeout) to see when data is
available on the socket.  I have 600 clients hitting my web server.

Quite frequently, what happens is that some of the sockets that I am waiting
on in the select (read or write) just dont have any activity in them for
more than 20 seconds or so.... its like the client never sent any data over
or is still waiting to connect.

What could I be doing wrong (what are the common mistakes?)

Thanks
Lee

------Original Message------
From: William T Wilson <fluffy@snurgle.org>
To: Lee Chin <leechin@mail.com>
Sent: March 28, 2001 9:58:35 PM GMT
Subject: Re: FWD: 3 NIC cards problem


On Wed, 28 Mar 2001, Lee Chin wrote:

> I have a program listening for socket connections on 192.168.1.1, port 80.
>
> What I want to do is have incomming connection requets for IP 192.168.2.1
> and 192.168.3.1 on port 80 also be handled by my server running on
> 192.168.1.1:80
>
> How do I do this in Linux?

If you use INADDR_ANY in your sockaddr struct that you pass to bind,
instead of your IP address, it should listen on all network interfaces.


______________________________________________
FREE Personalized Email at Mail.com
Sign up at http://www.mail.com/?sr=signup
