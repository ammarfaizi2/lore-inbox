Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262734AbTC0Oaw>; Thu, 27 Mar 2003 09:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262742AbTC0Oaw>; Thu, 27 Mar 2003 09:30:52 -0500
Received: from [192.35.37.50] ([192.35.37.50]:30170 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id <S262734AbTC0Oav>; Thu, 27 Mar 2003 09:30:51 -0500
Date: Thu, 27 Mar 2003 09:41:46 -0500
From: Chuck Winters <cwinters@atl.lmco.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: UDP sendmsg error # -95
Message-ID: <20030327144146.GA31207@atl.lmco.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kernelnewbies@nl.linux.org
References: <F69r3sNbCJGe1xqZFWF0000a7cb@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F69r3sNbCJGe1xqZFWF0000a7cb@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing a quick search through the code, it looks like the msg.msg_flags
may have MSG_OOB set.  You can see it in udp_sendmsg in the file udp.c

Chuck

On Thu, Mar 27, 2003 at 08:33:43AM +0000, shesha bhushan wrote:
> Hi,
> 
> I am using UDP to in the kernel space. I have implemented as follows. But 
> the sock_sendmsg is returning "-95". Could any one let me know what is the 
> problem here..
> 
> Thanking You
> Shesha
> 
> ==============================
>        strcpy(host_ip_ch,TARG_IP);
>        host_ip = ntohl(my_inet_addr(host_ip_ch));
>        sprintf(host_ip_long,"%u",host_ip);
>        soc_addr->sin_addr.s_addr = 
> htonl(simple_strtoul(host_ip_long,NULL,0));
> 
>        soc_addr->sin_family = PF_INET;
>        soc_addr->sin_port = htons(PORT_NUM);
> 
>        msg.msg_name = soc_addr;
>        msg.msg_namelen = sizeof(struct sockaddr_in);
> 
>        oldfs = get_fs();
>        set_fs(KERNEL_DS);
> 
>        retval = sock_sendmsg(sock, &msg, send_length);
> 
>        set_fs(oldfs);
> 
> ===========================================================
> 
> 
> _________________________________________________________________
> Vrroooom?? Fasten your seatbelts. 
> http://server1.msn.co.in/msnSpecials/formula2003/index.asp Get set for F1 
> 2003
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
