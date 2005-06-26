Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFZKHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFZKHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 06:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVFZKHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 06:07:13 -0400
Received: from mail-1.netbauds.net ([62.232.161.102]:25260 "EHLO
	mail-1.netbauds.net") by vger.kernel.org with ESMTP id S261340AbVFZKHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 06:07:05 -0400
Message-ID: <42BE7E38.9070703@netbauds.net>
Date: Sun, 26 Jun 2005 11:06:48 +0100
From: "Darryl L. Miles" <darryl@netbauds.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org>
In-Reply-To: <20050625234611.118b391d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Darryl L. Miles" <darryl@netbauds.net> wrote:
>  
>
>>[ modules getting loaded out-of-order and in parallel from initrd ]
>>    
>>
>
>On June 7, Martin Wilck reported:
>  
>
>>It turned out to be a problem with Red Hat's nash that didn't check the 
>>returned pid in it's wait4() call and thus ended up insmod'ing mutliple 
>>modules simultaneously, leading to "Unkown symbol" errors. Yuck, it took 
>>me a day figure that out.
>>
>>That bug is fixed in redhat's "mkinitrd" package 4.2.0.3-1 and later, 
>>but that package is currently only in Fedora's "Development" tree.
>>    
>>

Found the thread:   
http://www.ussg.iu.edu/hypermail/linux/kernel/0506.0/1556.html


This works for me:

wget 
http://download.fedora.redhat.com/pub/fedora/linux/core/development/i386/SRPMS/udev-058-1.src.rpm
rpmbuild --rebuild udev-058-1.src.rpm
rpm -Uvh /usr/src/redhat/RPMS/i386/udev-058-1.i386.rpm

wget 
http://download.fedora.redhat.com/pub/fedora/linux/core/development/i386/SRPMS/mkinitrd-4.2.17-1.src.rpm
rpmbuild --rebuild mkinitrd-4.2.17-1.src.rpm
rpm -Uvh /usr/src/redhat/RPMS/i386/mkinitrd-4.2.17-1.i386.rpm

Thanks


-- 
Darryl L. Miles


