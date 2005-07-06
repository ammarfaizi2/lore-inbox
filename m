Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVGFQIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVGFQIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVGFQHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:07:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16066 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262075AbVGFLwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:52:21 -0400
References: <11206164393426@foobar.com>
            <11206164424053@foobar.com>
            <84144f0205070603223790e4df@mail.gmail.com>
            <1120650075.4860.212.camel@localhost>
In-Reply-To: <1120650075.4860.212.camel@localhost>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 2.1.9.8 for 2.6.12: 603-suspend2_common-headers.patch
Date: Wed, 06 Jul 2005 14:52:20 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CBC5F4.00007CD1@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-06 at 20:22, Pekka Enberg wrote:
> > > +
> > > +extern int suspend_snprintf(char * buffer, int buffer_size, const char *fmt, ...);
> > 
> > What's wrong with regular snprintf?

Nigel Cunningham writes:
> If there's a buffer overrun, it returns the number of bytes it wanted to
> use, not the number actually used.

But on buffer overrun, you know it wrote size-1 characters. I am unconvinced 
you need a special snprintf() for suspend. Are there other potential users? 
If not, please consider dropping suspend_snprintf completelely. 

                Pekka 
