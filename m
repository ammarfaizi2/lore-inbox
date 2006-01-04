Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWADSOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWADSOj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWADSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:14:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48401 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932554AbWADSOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:14:38 -0500
Date: Wed, 4 Jan 2006 18:14:25 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning in 8250.c
Message-ID: <20060104181425.GE3119@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200601031012.49068.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601031012.49068.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 10:12:48AM +0200, Denis Vlasenko wrote:
>   CC      drivers/serial/8250.o
> /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: 'transmit_chars' declared inline after being called
> /.1/usr/srcdevel/kernel/linux-2.6.15-rc7.src/drivers/serial/8250.c:1085: warning: previous declaration of 'transmit_chars' was here
> 
> Since this function is not small, inlining effect is way below noise floor.
> Let's just remove _INLINE_.

I think we want to remove _INLINE_ from both receive_chars and
transmit_chars.  Both functions aren't small, so...

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
