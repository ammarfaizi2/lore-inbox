Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSBHXlo>; Fri, 8 Feb 2002 18:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSBHXle>; Fri, 8 Feb 2002 18:41:34 -0500
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:58309 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287841AbSBHXlV>; Fri, 8 Feb 2002 18:41:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: tcp_keepalive_intvl vs tcp_keepalive_time?
Date: Fri, 8 Feb 2002 18:42:17 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020208234120.OVLN12059.femail26.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would someone be kind enough to explain the difference between 
tcp_keepalive_intvl and tcp_keepalive_time?  
Documentation/filesystems/proc.txt says tcp_keepalive_time is the interval 
between sending keepalive probes, but doesn't mention tcp_keepalive_intvl...

A quick grep through the source code says tcp_keepalive_intvl wanders through 
keepalive_intv_when which is used in tcp_keepalive_time in a way that sort of 
implies it's the timeout between keapalive packets.  So what's 
tcp_keepalive_time?

The problem I'm trying to track down is ssh connections where the connection 
times out but the session doesn't go away until a key is pressed.  (I.E. 
blocking reads don't notice the connection going down underneath them, not 
even if left overnight.)

It's kind of frustrating, actually...

Rob
