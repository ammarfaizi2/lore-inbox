Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbULIN5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbULIN5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbULIN5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:57:54 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:24962 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261311AbULIN5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:57:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=f1jYNcYQSaCkl8cd7/wobfbEUyhnWOamLGJ2sHzMPt6wwaZACVHRpwsDdExnzzHYlD6iS1Qf2NecLr/pidPSl/1AAgojV1yXyewLifxAq6I7XD7Oz6h4Zpb1GOMzP8L9gOguKBrofisxbilUbibVPui0PZmBcKgQ6X5G1inDOaM=
Message-ID: <7d34f21904120905573ddb6d25@mail.gmail.com>
Date: Thu, 9 Dec 2004 19:27:49 +0530
From: Phani Kandula <phani.lkml@gmail.com>
Reply-To: Phani Kandula <phani.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: doubt about "switch" - default case in af_inet.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a newbie to the Linux. I'm using 2.6.8 kernel. 
In /usr/src/linux/net/ipv4/af_inet.c I came across this...
 <code>
     switch (sock->state) {
     default:
     //do something..
         goto out;
     case SS_CONNECTED:
     //do something..
         goto out;
     case SS_CONNECTING:
     //do something..
         break;
     case SS_UNCONNECTED:
     //do something..
         break;
     }
 </code>

Is there any advantage in having 'default' as the first case? 
My understanding is that it will be useful only when 'default' is the
most likely case (in general).

Even then, my doubt: How will compiler (say gcc) implement 'default'
as the first value? Program is supposed to see all the cases and then
decide 'default'. Is this correct?

So, is this the best way to do it? please clarify..

Thanks,
Phani
