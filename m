Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVDBSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDBSYo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVDBSYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:24:43 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:4493 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261170AbVDBSYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:24:42 -0500
Date: Sat, 2 Apr 2005 10:24:38 -0800
From: Chris Wedgwood <cw@f00f.org>
To: ooyama eiichi <ooyama@tritech.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack size
Message-ID: <20050402182438.GA29095@taniwha.stupidest.org>
References: <20050403.024634.88477140.ooyama@tritech.co.jp> <20050402175345.GA28710@taniwha.stupidest.org> <20050403.031542.23015132.ooyama@tritech.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403.031542.23015132.ooyama@tritech.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 03:15:42AM +0900, ooyama eiichi wrote:

> in i386 and ia64.

search for CONFIG_DEBUG_STACKOVERFLOW in arch/i386/kernel/irq.c

ia64 has fairly large stacks so you probably won't need to check there
if you get the above working

> because my driver hungs the machine by an certain ioctl.  and it
> seems to me there is no bad in the code correspond to the ioctl,
> except for that it is using large auto variables.  (some functions
> are useing ~1KB autos)

don't do that, even if you make it 'apparently' work for you it will
just end up being a problem mater on or for someone else
