Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWFZSKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWFZSKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWFZSKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:10:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932154AbWFZSKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:10:43 -0400
Date: Mon, 26 Jun 2006 11:10:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: vagabon.xyz@gmail.com, mel@skynet.ie, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up the bootmem allocator
Message-Id: <20060626111022.0b31fa6e.akpm@osdl.org>
In-Reply-To: <1151344691.10877.44.camel@localhost.localdomain>
References: <449FDD02.2090307@innova-card.com>
	<1151344691.10877.44.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006 10:58:11 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> > It also removes __init tags in the header file and hopefully make it
> > easier to read. 
> 
> I think I kinda like when these are present in headers.  I usually
> stumble across the header declarations before I do the ones in the .c
> files, and it is always nice to see the header visually _matching_
> the .c file, and how the variable is intended to be used

__init in headers is pretty useless because the compiler doesn't check it,
and they get out of sync relatively frequently.  So it you see an __init
in a header file, it's quite unreliable and you need to check the
definition anyway.
