Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264088AbTCXEHW>; Sun, 23 Mar 2003 23:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264091AbTCXEHV>; Sun, 23 Mar 2003 23:07:21 -0500
Received: from f88.pav2.hotmail.com ([64.4.37.88]:1542 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264088AbTCXEHV>;
	Sun, 23 Mar 2003 23:07:21 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: GETHOSTBYNAME()
Date: Mon, 24 Mar 2003 04:18:22 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F88IYUmwO9suAkWORuX000101d2@hotmail.com>
X-OriginalArrivalTime: 24 Mar 2003 04:18:23.0119 (UTC) FILETIME=[689EF9F0:01C2F1BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
I am trying to find the gethostbyname() equivalent function in kernel space. 
Does any one know that.
The reason is...
I am using UDP to transfer data from one machine to another. It is not one 
time transfer. Once I get a message from machine A; I need to send some 
message back to Machine A from Machine B. For that I was using the following 
lines in user space program. I need to do the same in kernel space. Could 
any one help me out in this.

struct hostent *data;
struct sockaddr_in server;
int sock;

  sock = socket(AF_INET, SOCK_DGRAM , 0)

/* binding and all are done here */

  data = gethostbyname("158.168.1.1");
  memcpy (&server.sin_addrs, data->h_addr, data->h_length);
  retval = sendto(sock,msg,sizeof(msg), 0, (struct sockaddr *) &server, 
sizeof server);


Thanking You
Shesha

_________________________________________________________________
Cricket - World Cup 2003 http://server1.msn.co.in/msnspecials/worldcup03/ 
News, Views and Match Reports.

