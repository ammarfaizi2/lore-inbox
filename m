Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbULOUcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbULOUcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbULOUcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:32:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:28813 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262427AbULOUcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:32:03 -0500
Date: Wed, 15 Dec 2004 21:42:33 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-os@analogic.com
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][example patch inside] return statement cleanups, get rid
 of unnecessary parentheses
In-Reply-To: <Pine.LNX.4.61.0412151507320.4365@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0412152138260.3864@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412152036020.3864@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0412151507320.4365@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, linux-os wrote:

> 
> I agree except for the rare case where one returns the result
> of a complex sequence like:
> 
> 	return -b + sqrt(-b*4.0*a*c)/2.0*a;
> 
> This should remain:
> 
> 	return (-b + sqrt(-b*4.0*a*c)/2.0*a);
> 
I agree completely, for complex returns the parentheses should remain. In 
most cases it's pretty obvious that they should just go away, in the few 
cases where I'm in doubt or when the expression is clearly complex 
enough to warrent them for readabillity, I'll leave them.

That's two people agreeing (I got one reply off list that's in agreement 
as well), a few more and I'll go into patch-mania mode ;)
Thank you for commenting.

-- 
Jesper Juhl

