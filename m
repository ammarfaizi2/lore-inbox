Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWFHCbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWFHCbF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWFHCbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:31:05 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:18656 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932484AbWFHCbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:31:04 -0400
Date: Wed, 7 Jun 2006 22:31:02 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ltt-dev@shafik.org
Subject: Re: Interrupts disabled for too long in printk
Message-ID: <20060608023102.GA22022@Krystal>
References: <20060603111934.GA14581@Krystal> <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <9e4733910606071837l4e81c975t8d531ed9810af60f@mail.gmail.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 22:28:27 up 33 days,  5:37,  1 user,  load average: 1.16, 1.26, 1.24
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jon Smirl (jonsmirl@gmail.com) wrote:
> You can look at this problem from the other direction too. Why is it
> taking 15ms to get between the two points? If IRQs are off how is the
> serial driver getting interrupts to be able to display the message? It
> is probably worthwhile to take a look and see what the serial console
> driver is doing.

Hi John,

The serial port is configured at 38000 bauds. It can therefore transmit 4800
bytes per seconds, for 72 characters in 15 ms. So the console driver would be
simply busy sending characters to the serial port during that interrupt
disabling period.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
