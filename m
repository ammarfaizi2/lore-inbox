Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTBUFNp>; Fri, 21 Feb 2003 00:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTBUFNp>; Fri, 21 Feb 2003 00:13:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:35003 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267153AbTBUFNn>;
	Fri, 21 Feb 2003 00:13:43 -0500
Date: Thu, 20 Feb 2003 21:25:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: iosched: effect of streaming read on interactivity
Message-Id: <20030220212521.09da8c7c.akpm@digeo.com>
In-Reply-To: <20030220212304.4712fee9.akpm@digeo.com>
References: <20030220212304.4712fee9.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2003 05:23:43.0081 (UTC) FILETIME=[664B7590:01C2D969]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similarly, start a large streaming read on the test box and see how long it
then takes to pop up an x client running on that box with

	time ssh testbox xterm -e true


2.4.21-4:	45 seconds
2.5.61+hacks:	5 seconds
2.5.61+CFQ:	8 seconds
2.5.61+AS:	9 seconds


