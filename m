Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbTC0IWi>; Thu, 27 Mar 2003 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbTC0IWi>; Thu, 27 Mar 2003 03:22:38 -0500
Received: from f69.pav2.hotmail.com ([64.4.37.69]:16908 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261810AbTC0IWg>;
	Thu, 27 Mar 2003 03:22:36 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: UDP sendmsg error # -95
Date: Thu, 27 Mar 2003 08:33:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F69r3sNbCJGe1xqZFWF0000a7cb@hotmail.com>
X-OriginalArrivalTime: 27 Mar 2003 08:33:45.0085 (UTC) FILETIME=[9476B2D0:01C2F43B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using UDP to in the kernel space. I have implemented as follows. But 
the sock_sendmsg is returning "-95". Could any one let me know what is the 
problem here..

Thanking You
Shesha

==============================
        strcpy(host_ip_ch,TARG_IP);
        host_ip = ntohl(my_inet_addr(host_ip_ch));
        sprintf(host_ip_long,"%u",host_ip);
        soc_addr->sin_addr.s_addr = 
htonl(simple_strtoul(host_ip_long,NULL,0));

        soc_addr->sin_family = PF_INET;
        soc_addr->sin_port = htons(PORT_NUM);

        msg.msg_name = soc_addr;
        msg.msg_namelen = sizeof(struct sockaddr_in);

        oldfs = get_fs();
        set_fs(KERNEL_DS);

        retval = sock_sendmsg(sock, &msg, send_length);

        set_fs(oldfs);

===========================================================


_________________________________________________________________
Vrroooom…… Fasten your seatbelts. 
http://server1.msn.co.in/msnSpecials/formula2003/index.asp Get set for F1 
2003

