Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVF0P2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVF0P2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 11:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVF0PYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:24:08 -0400
Received: from coderock.org ([193.77.147.115]:43394 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262046AbVF0O47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 10:56:59 -0400
Date: Mon, 27 Jun 2005 16:56:48 +0200
From: Domen Puncer <domen@coderock.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Driver writer's guide to sleeping
Message-ID: <20050627145648.GA28445@nd47.coderock.org>
References: <200506251250.18133.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506251250.18133.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/05 12:50 +0300, Denis Vlasenko wrote:
> Hi folks,
> 
...
> msleep_interruptible(ms)
> 	Sleeps ms msecs (or more) unless has been woken up (signal, waitqueue...).
>     Q: exact list of possible waking events? (I'm a bit overwhelmed by multitude
>     of slightly different waitqueues, tasklets, softirqs, bhs...)

Only signal (or, obviously, timeout) will wake it. wake_up*() will not.
