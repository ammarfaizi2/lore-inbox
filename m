Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVL0OzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVL0OzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 09:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVL0OzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 09:55:00 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:61802 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932343AbVL0Oy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 09:54:59 -0500
Date: Tue, 27 Dec 2005 09:54:45 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: something about jiffies wraparound overflow
In-reply-to: <7cd5d4b40512262046w6f7a8161jfaf1e618e5722b4@mail.gmail.com>
To: jeff shia <tshxiayu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1135695285.31669.2.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <7cd5d4b40512262046w6f7a8161jfaf1e618e5722b4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 12:46 +0800, jeff shia wrote:
>   1.why the macros of time_after can solve the jiffies wraparound problem?

Basically it assumes that the two values you are comparing will never be
more than MAX_ULONG/2 apart. Which for jiffies means 270 some odd days
on 32-bit platforms.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

