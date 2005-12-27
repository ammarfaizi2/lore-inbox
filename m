Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVL0ECh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVL0ECh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 23:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVL0ECh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 23:02:37 -0500
Received: from [139.30.44.16] ([139.30.44.16]:22356 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S932197AbVL0ECh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 23:02:37 -0500
Date: Tue, 27 Dec 2005 05:02:32 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: jeff shia <tshxiayu@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: do we still need the jiffies wraparound functions ?
In-Reply-To: <7cd5d4b40512261932v12149210u52cf97c4bc203871@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0512270458260.10175@gockel.physik3.uni-rostock.de>
References: <7cd5d4b40512261932v12149210u52cf97c4bc203871@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, jeff shia wrote:

> Under the kernel 2.6.x,the jiffies is defined as u64.We cannot count
> on it to overflow.

Actually, no. jiffies is still defined as unsigned long, which reduces 
overhead where 64 bit jiffies are not needed. Only jiffies_64 is an u64.

> Do we still need the functions to solve this problem?

Yes.

Tim
