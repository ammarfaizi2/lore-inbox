Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWHBWhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWHBWhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 18:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbWHBWhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 18:37:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57269 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932284AbWHBWhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 18:37:34 -0400
Date: Wed, 2 Aug 2006 18:37:33 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tty_io wtf.
Message-ID: <20060802223733.GA20485@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060802223604.GI3639@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802223604.GI3639@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 06:36:04PM -0400, Dave Jones wrote:
 > I knew I'd regret digging in the tty code.
 > Can someone enlighten me as to what this *should* be doing?
 > 
 > int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
 >                 size_t size)
 > {   
 >    	.... 
 >     /* There is a small chance that we need to split the data over
 >        several buffers. If this is the case we must loop */
 >     while (unlikely(size > copied));
 >     return copied;
 > }   
 > 
 > 
 > Looping I can understand, but forever ?
 > Given we're not advancing 'copied', can we just kill that while loop?
 > Or should we be changing it with each iteration?

Disregard, it's the end of a do { } while.
I've been staring at this too long.

		Dave

-- 
http://www.codemonkey.org.uk
