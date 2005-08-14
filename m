Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVHNAWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVHNAWV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 20:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVHNAWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 20:22:21 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:32919 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751354AbVHNAWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 20:22:20 -0400
Date: Sat, 13 Aug 2005 17:22:19 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: steve roussey <iamstever@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question about SO_LINGER
In-Reply-To: <57792e85050810175041d2bad4@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0508131719540.5173@twinlark.arctic.org>
References: <57792e85050810175041d2bad4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, steve roussey wrote:

> socket to shut down.  Apache has a workaround called lingering_close()
> that tries to address broken SO_LINGER implementations, but it also blocks."

apache 1.x is single threaded / forked, so yeah it blocks.  the 
implementation is there because very few SO_LINGER implementations 
actually worked in the 90s.  the method used by apache 1.x is easy to 
modify into a non-blocking form... which could be how they did it in 2.x 
(i stopped hacking on apache sometime early in 2.x development).

-dean
