Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVBJI4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVBJI4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 03:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVBJI4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 03:56:04 -0500
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:1152 "EHLO
	three.holviala.com") by vger.kernel.org with ESMTP id S262054AbVBJIxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 03:53:05 -0500
Message-ID: <420B20E8.4010300@holviala.com>
Date: Thu, 10 Feb 2005 10:52:56 +0200
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Spontaneous reboot with 2.6.10 and NFSD
References: <420B0FCD.4000801@holviala.com> <420B1AF4.6060103@holviala.com>
In-Reply-To: <420B1AF4.6060103@holviala.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala wrote:
> Kim Holviala wrote:
> 
>> To narrow down the problem, I've tried the following:
>>
>> - copied files from a different client running Gentoo: reboot
>> - exported a non-raided partition (hdc9) and tried that: reboot
>> - switched 2.6.10 to 2.6.11-rc3: reboot, but it took longer
> 
> 
> - tried with both udp and tcp mounts (nfsv3 both): reboot
> - tried with 2.6.8.1: reboot

- tried with local NFS mount (mount localhost:/export/tmp ...): reboot
- tried with user-mode nfs server (nfs-user-server): OK

Hmmm. So it looks like that when I transfer a lot of data through the 
kernel NFS server, it reboots the server. But if I transfer the same 
data using ssh or user-mode nfs server, it all works like it should

I'm out of ideas.



Kim
