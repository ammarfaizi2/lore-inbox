Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWGSJrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWGSJrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWGSJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 05:47:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:33941 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964777AbWGSJrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 05:47:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:organization:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=VoC3XF/0LFW8/uddAVeTuyAdoPG5zdWznkWxa3dbjQbQe/ekAVbeOs3qaTms5YydKo/suUtEnsXanNS5f72EM08QxPL8+A6c+Lk6WrGlOCa6aULyvWZyok9b7xD6thqgqvv0kCbWntT9s8b2b/m/O34oRzYqgAE74X6+yd0IRDc=
Message-ID: <44BE0129.2090600@innomedia.soft.net>
Date: Wed, 19 Jul 2006 15:23:45 +0530
Reply-To: chinmaya@innomedia.soft.net
Organization: Innomedia Technologies Pvt. Ltd.
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: How to get the IP address in kernel module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Chinmaya Mishra <chinmaya4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can you provide an example how to invoke ioctl on
device in kernel module.

For example. I want to find out the IP address of
my eth0 and I want to make SIOCSIFADDR on it from kernel module.


At user space i am doing it like this.....

unsigned long *ip;
char *iface;
int sockfd;
struct ifreq ifr;
strcpy(ifr.ifr_name, iface);    // interface name 'eth0'
sockfd = socket(AF_INET,SOCK_DGRAM,0);
ioctl(sockfd, SIOCGIFADDR, (char*)&ifr);
memcpy(ip, &(ifr.ifr_addr.sa_data[2]),4); //Copy the ip addr
close(sockfd);

How to port this in kernel space.

Thank you.
Chinmaya
