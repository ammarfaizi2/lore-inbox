Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932728AbWCPUmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWCPUmE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWCPUmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:42:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:17547 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932728AbWCPUmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:42:01 -0500
Date: Thu, 16 Mar 2006 21:41:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bret Towe <magnade@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs udp 1000/100baseT issue
In-Reply-To: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>a while ago i noticed a issue when one has a nfs server that has
>gigabit connection
>to a network and a client that connects to that network instead via 100baseT
>that udp connection from client to server fails the client gets a
>server not responding
>message when trying to access a file, interesting bit is you can get a directory
>listing without issue
>work around i found for this is adding proto=tcp to the client side
>and all works
>without error

UDP has its implications, like silently dropping packets when the link 
is full, by design. Try tcpdump on both systems and compare what packets 
are sent and which do arrive. The error message is then probably because 
the client is confused of not receiving some packets.

>error message i see client side are as follows:
>nfs: server vox.net not responding, still trying
>nfs: server vox.net not responding, still trying
>nfs: server vox.net not responding, still trying


Jan Engelhardt
-- 
