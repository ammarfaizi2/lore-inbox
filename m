Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVLZWgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVLZWgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVLZWgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:36:47 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11477 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751090AbVLZWgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:36:46 -0500
Date: Mon, 26 Dec 2005 23:36:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikado <mikado4vn@yahoo.com>
cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: How to obtain process ID that created a packet
In-Reply-To: <20051226162218.78162.qmail@web53704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0512262334210.12671@yvahk01.tjqt.qr>
References: <20051226162218.78162.qmail@web53704.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>Is there any way to catch REAL pid that generated a packet from 'struct sk_buff', 'struct sock',
>'struct socket',
>'struct file' or etc... ? direct/indirect ways are accepted.

The question is: when do you test for the PID? You would have to do it 
within send(), because anywhere else, you do not know. A socket may be 
shared among multiple processes (most simple way: fork()).



Jan Engelhardt
-- 
