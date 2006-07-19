Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWGSJwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWGSJwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbWGSJwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:52:35 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:46457 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964778AbWGSJwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:52:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ff2pdBSC0zA8hriuRsh0joiTNQFX8QbU+wWhXwS9i5+/pZAxCt43Ow7e1xaLZHkivRM8UW2aHMWCdvko9PeAtEa0MRKxMHC2g2xm477ls6QcnixAHrnq/Qn/MvGa7aq611O9e0rWlyiNg8DAcMRUxMM5jZhRZ3QpL46F6dm0EZQ=
Message-ID: <f4586a2e0607190252g61e97f35o220dfde4e5401afd@mail.gmail.com>
Date: Wed, 19 Jul 2006 15:22:33 +0530
From: "=?UTF-8?Q?Parag_N(=E0=A4=AA=E0=A4=B0=E0=A4=BE=E0=A5=9A)?=" 
	<panemade@gmail.com>
To: chinmaya@innomedia.soft.net
Subject: Re: Gettin own IP address thorugh ioctl in kernel space.
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <44BDFC64.607@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BDFC64.607@innomedia.soft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 7/19/06, Chinmaya Mishra <chinmaya4@gmail.com> wrote:
> Hi,
>
> Can you provide an example how to invoke ioctl on
> device in kernel module.
>
> For example. I want to find out the IP address of
> my eth0 and I want to make SIOCSIFADDR on it from
> kernel module.
>
>
> At user space i am doing it like this.....
>
>  unsigned long *ip;
>  char *iface;
>  int sockfd;
>  struct ifreq ifr;
>  strcpy(ifr.ifr_name, iface);   // interface name 'eth0'
>  sockfd = socket(AF_INET,SOCK_DGRAM,0);
>  ioctl(sockfd, SIOCGIFADDR, (char*)&ifr);
>  memcpy(ip, &(ifr.ifr_addr.sa_data[2]),4); //Copy the ip addr
>  close(sockfd);
>
> How to port this in keernel space.
 Check point 29 from http://kasperd.net/~kasperd/comp.os.linux.development.faq.
Modify that source code according to your needs.
Regards,
Parag.
