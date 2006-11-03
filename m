Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753491AbWKCTzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbWKCTzM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 14:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbWKCTzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 14:55:11 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:19394 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP
	id S1753491AbWKCTzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 14:55:09 -0500
Message-ID: <01d001c6ff81$b4bb5dc0$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: <yoshfuji@linux-ipv6.org>
Cc: <linux-net@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <01a501c6ff74$6fc52c80$962e8d52@aldipc> <20061104.034726.27678443.yoshfuji@linux-ipv6.org>
Subject: Re: unregister_netdevice: waiting for eth0 to become free
Date: Fri, 3 Nov 2006 20:53:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The ipv6 module cannot be unloaded once it has been
> loaded.

sorry,  i thought i could rmmod evey module which was insmod/modprobe'd 
before and i didn`t know that there are exceptions

> I'm not sure what is happened with vmware.

i think this is not completely related to vmware - but maybe this is being 
triggered more often by vmware ?
http://www.google.de/search?hl=de&q=%22unregister_netdevice%3A+waiting+for+eth0+to+become+free

it`s really strange, but after taking a look,  vmware seems to recommend 
disabling ipv6 for _every_ linux based guest OS in general:
http://pubs.vmware.com/guestnotes/wwhelp/wwhimpl/common/html/wwhelp.htm?context=gos_ww5_output&file=choose_install_guest_os.html

since there are already running millions of  linux based VMs in this world, 
i think this isn`t very good "promotion" for ipv6, if vmware recommending 
disabling it.
ok, there are not that much people already needing ipv6 NOW, but the later 
they are running it and the later outstanding bugs being fixed, the harder 
it will be to convert from ipv4 to ipv6....

roland



----- Original Message ----- 
From: "YOSHIFUJI Hideaki / ????" <yoshfuji@linux-ipv6.org>
To: <devzero@web.de>
Cc: <linux-net@vger.kernel.org>; <linux-kernel@vger.kernel.org>; 
<yoshfuji@linux-ipv6.org>
Sent: Friday, November 03, 2006 7:47 PM
Subject: Re: unregister_netdevice: waiting for eth0 to become free


> In article <01a501c6ff74$6fc52c80$962e8d52@aldipc> (at Fri, 3 Nov 2006 
> 19:18:17 +0100), "roland" <devzero@web.de> says:
>
>> vserver1:~ # rmmod ipv6
>> ERROR: Module ipv6 is in use by ip6t_REJECT
>> vserver1:~ # rmmod ip6t_REJECT
>> ERROR: Module ip6t_REJECT is in use
>
> The ipv6 module cannot be unloaded once it has been
> loaded.
>
> I'm not sure what is happened with vmware.
>
> --yoshfuji 

