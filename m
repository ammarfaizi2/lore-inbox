Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264097AbTCXEm5>; Sun, 23 Mar 2003 23:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264098AbTCXEm5>; Sun, 23 Mar 2003 23:42:57 -0500
Received: from [196.12.44.6] ([196.12.44.6]:32998 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S264097AbTCXEm4>;
	Sun, 23 Mar 2003 23:42:56 -0500
Date: Mon, 24 Mar 2003 10:25:11 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
cc: linux-kernel@vger.kernel.org, <kernelnewbies@nl.linux.org>
Subject: Re: GETHOSTBYNAME()
In-Reply-To: <F88IYUmwO9suAkWORuX000101d2@hotmail.com>
Message-ID: <Pine.LNX.4.44.0303241019280.13253-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,
	i dont think there is one similar to gethostbyname in the 
kernel-space.  I do think so because most of the work done by 
gethostbyname is based on the nameservices and is generally not required 
in the kernel-space.  Implementing it should not be that big a problem.
once you have the IP of the name server (/etc/resolve.conf???) you can 
always connect to it and get the IP of the given host.

Prasad.


On Mon, 24 Mar 2003, shesha bhushan wrote:

> Hi All
> I am trying to find the gethostbyname() equivalent function in kernel space. 
> Does any one know that.
> The reason is...
> I am using UDP to transfer data from one machine to another. It is not one 
> time transfer. Once I get a message from machine A; I need to send some 
> message back to Machine A from Machine B. For that I was using the following 
> lines in user space program. I need to do the same in kernel space. Could 
> any one help me out in this.
> 
> struct hostent *data;
> struct sockaddr_in server;
> int sock;
> 
>   sock = socket(AF_INET, SOCK_DGRAM , 0)
> 
> /* binding and all are done here */
> 
>   data = gethostbyname("158.168.1.1");
>   memcpy (&server.sin_addrs, data->h_addr, data->h_length);
>   retval = sendto(sock,msg,sizeof(msg), 0, (struct sockaddr *) &server, 
> sizeof server);
> 
> 
> Thanking You
> Shesha
> 
> _________________________________________________________________
> Cricket - World Cup 2003 http://server1.msn.co.in/msnspecials/worldcup03/ 
> News, Views and Match Reports.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Failure is not an option

