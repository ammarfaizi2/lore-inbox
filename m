Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUCGFAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 00:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUCGFAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 00:00:52 -0500
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:23813 "EHLO
	pc16.dolda2000.com") by vger.kernel.org with ESMTP id S261726AbUCGFAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 00:00:51 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16458.44160.469394.230025@pc7.dolda2000.com>
Date: Sun, 7 Mar 2004 06:00:48 +0100
To: linux-kernel@vger.kernel.org
Subject: IP_TOS setsockopt filters away MinCost
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found some code in net/ipv4/ip_sockglue.c that I failed to make
sense of. In the setsockopt code for setting IP_TOS, it erases the two
lowest bits (I dunno what bit 0 in the TOS is - last I looked it was
reserved, but bit 1 is for minimal cost), and replaces them with what
was already set for the socket (only for SOCK_STREAM sockets,
though). That means that one cannot set minimal cost TOS on stream
sockets.

This didn't make sense to me. Is there some reason behind this, and
would someone like to explain it to me in that case? I just spent an
hour trying to debug my program to find it why it didn't want to set
minimal cost, while the other three TOS options worked.

Fredrik Tolf

