Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVJNKjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJNKjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 06:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVJNKjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 06:39:31 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:28535 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750705AbVJNKja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 06:39:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=MJ40MidPADI8kzoxTmPIePRx0dgbSFiM11Vszt18XoSzaUrpNc4/ja/o4oS9ueiD1dts5E4PPwZ5zaZHOhWSkIg0mxlx1GP1fdz5QATzcS0uogPzNR6fJ4CPjjKMRTIgdz30qBi3SM9DSjzyfOECODgjfVW/feWqqNHTRL05fyI=
Message-ID: <434F8B23.7090201@gmail.com>
Date: Fri, 14 Oct 2005 18:40:35 +0800
From: Yan Zheng <yzcorp@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH]The type of inet6_ifinfo_notify event  in addrconf_ifdown().
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe inet6_ifinfo_notify event type should be RTM_DELLINK in 
addrconf_ifdown().

Signed-off-by: Yan Zheng<yanzheng@21cn.com>

Index:  net/ipv6/addrconf.c
------------------------------------------------------------------------
--- linux-2.6.14-rc4-git2/net/ipv6/addrconf.c    2005-10-14 
18:28:01.000000000 +0800
+++ linux/net/ipv6/addrconf.c    2005-10-14 18:31:15.000000000 +0800
@@ -2167,7 +2167,7 @@
 
     /* Step 5: netlink notification of this interface */
     idev->tstamp = jiffies;
-    inet6_ifinfo_notify(RTM_NEWLINK, idev);
+    inet6_ifinfo_notify(RTM_DELLINK, idev);
    
     /* Shot the device (if unregistered) */
 

