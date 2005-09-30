Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVI3CfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVI3CfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVI3CfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:35:10 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:20985 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932419AbVI3CfJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:35:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bNW1OP2llT1EqDJBhkGRiYpPlX3YyzwV1J7KG+UqIVS2BDgtj4z5EEIa2Ijvg42DRTRRsR1Q4Mb6gyVRgrnDX/W7n05AAjMRgaYBBizr/dZguWlk5demXjgDvIla6pEFgJ5CTnWmScdWuL2/RRflXO8Sgt1SZRKk1tYrsaL7GYs=
Message-ID: <b1df7a2c0509291935u79df2643p@mail.gmail.com>
Date: Fri, 30 Sep 2005 10:35:09 +0800
From: zhuang zhuanghou <zhuanghou@gmail.com>
Reply-To: zhuang zhuanghou <zhuanghou@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How can I control the network package
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

     I have a linux server  with two GE nics configured as follows:
    eth0   10.10.12.1       netmask 255.255.255.0
    eth1   10.10.12.111   netmask  255.255.255.0

    One service application running on it (as a kernel module) and accepts
all the requests from clients on the same subnet (i.e. with subnet 10.10.12.x),
and all the clients will send requests to these two nic round-robinly.
when eth0
accept the request, the corresponding result will be sent back from eth0 too,
but when eth1 accepted the request, its result still go back from eth0, not eth1
due to network route, but I need it go back through where it came from,
so how can I do that?
   BTW: the server has two listen sockets bind to these two ips
respectively, use
            UDP protocol

  Thanks!
