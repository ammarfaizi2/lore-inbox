Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVCJNze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVCJNze (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCJNze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:55:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21933 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262611AbVCJNzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:55:23 -0500
Date: Wed, 9 Mar 2005 20:11:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michal Januszewski <spock@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [announce 7/7] fbsplash - documentation
Message-ID: <20050309191103.GA632@openzaurus.ucw.cz>
References: <20050308021706.GH26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308021706.GH26249@spock.one.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +The userspace helper
> +--------------------
> +
> +The userspace splash helper (by default: /sbin/splash_helper) is called by the
> +kernel whenever an important event occurs and the kernel needs some kind of
> +job to be carried out. Important events include console switches and graphic
> +mode switches (the kernel requests background images and configuration
> +parameters for the current console). The splash helper must be accessible at 
> +all times. If it's not, fbsplash will be switched off automatically.

Ugh, is not calling userspace when switching consoles deadlock-prone?
What if that helper tries to do printf()?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

