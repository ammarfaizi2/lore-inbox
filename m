Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUF3VMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUF3VMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 17:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUF3VMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 17:12:24 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:264 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262768AbUF3VMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 17:12:22 -0400
Message-ID: <40E3319D.3050100@techsource.com>
Date: Wed, 30 Jun 2004 17:33:17 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Joshua <jhudson@cyberspace.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore floppy boot image
References: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
In-Reply-To: <Pine.SUN.3.96.1040630143510.23723A-100000@grex.cyberspace.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Joshua wrote:

> +/*
> + * Routine errcode prints a diagnostic to the screen
> + * Used for debugging and for printing BIOS error codes
> + */
> +errcode:
> +	mov	%ah, %dh
> +	mov	$1, %cx
> +print_hex:
> +	mov	$10, %ah
> +	mov	$7, %bx
> +phl:	mov	%dh, %al
> +	shr	$4, %al
> +	and	15, %al
> +	add	$0x90, %al
> +	daa
> +	add	$0x40, %al
> +	daa
> +	int	$0x10
> +	shl	$4, %dx
> +	loop	phl

This loop will not loop.  You've set CX to 1.
LOOP is like "} while (--CX);".



