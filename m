Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTKHVPH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 16:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbTKHVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 16:15:06 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:34322 "EHLO
	cygnus-ext.enyo.de") by vger.kernel.org with ESMTP id S262123AbTKHVPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 16:15:04 -0500
Date: Sat, 8 Nov 2003 23:14:54 +0100
To: Thiago Rondon <thiago@ananke.com.br>
Cc: Peter Lieverdink <cafuego@cafuego.net>, linux-kernel@vger.kernel.org
Subject: Re: cryptoloop hard lockup 2.6.0-test5-mm4
Message-ID: <20031108221454.GA6542@deneb.enyo.de>
References: <5.1.0.14.2.20030923151949.01d37568@caffeine.cc.com.au> <20030923133624.GA2479@ananke.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923133624.GA2479@ananke.com.br>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Rondon wrote:

> -       static int least_priority;
> +       static int least_priority = 0;

This change has no effect whatsoever (objects with static storage
duration are always initialized).

Any other ideas?  I stumbled across this problem using vanilla
2.6.0-test9.
