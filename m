Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVCORtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVCORtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCORtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:49:33 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18147 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261688AbVCORss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:48:48 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] gcc4 fix for sn_serial.c
Date: Tue, 15 Mar 2005 09:48:02 -0800
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, pfg@sgi.com, linux-kernel@vger.kernel.org
References: <200503141132.39284.jbarnes@engr.sgi.com> <20050315010358.GF3207@stusta.de>
In-Reply-To: <20050315010358.GF3207@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503150948.03100.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 14, 2005 5:03 pm, Adrian Bunk wrote:
> > -static struct uart_driver sal_console_uart = {
> > +struct uart_driver sal_console_uart = {
> >   .owner = THIS_MODULE,
> >   .driver_name = "sn_console",
> >   .dev_name = DEVICE_NAME,
>
> Why can't you solve this without making sal_console_uart global?

I think that would mean moving some of the structure initializaiton into an 
init function somewhere.  But the compiler knows the addrs of these 
structures, so there must be a better way to do it, I just don't know it.  
Any suggestions?

Jesse
