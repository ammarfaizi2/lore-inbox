Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFGGmv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbTFGGmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:42:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8067 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261936AbTFGGmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:42:51 -0400
Date: Fri, 06 Jun 2003 23:53:40 -0700 (PDT)
Message-Id: <20030606.235340.85405522.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606210620.G3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net>
	<200306070000.h5700OsG002995@ginger.cmf.nrl.navy.mil>
	<20030606210620.G3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 21:06:20 -0300

   Yes, exactly: if you want to remove the phone, this also
   removes the call. In TCP/IP, this isn't the case. Your
   TCP connections will survive route changes, interface
   removals, etc.
   
But not a change in IP address :-)  TCP connections are
exactly like VCC's in this regard, the VCC here is defined
as saddr/sport/daddr/dport, and if any of these must change due
to an administrative act, it kills the "phone call" :-)
