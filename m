Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVEISN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVEISN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVEISN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:13:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54265 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261475AbVEISN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:13:57 -0400
Subject: Re: [PATCH] Priority Lists for the RT mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050509091133.GA25959@elte.hu>
References: <F989B1573A3A644BAB3920FBECA4D25A0331776B@orsmsx407>
	 <427C6D7D.878935F1@tv-sign.ru> <20050509073043.GA12976@elte.hu>
	 <427F1A99.58BCCB88@tv-sign.ru>  <20050509091133.GA25959@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1115662430.16016.4.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2005 11:13:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-09 at 02:11, Ingo Molnar wrote:

> What would be nice to achieve are [low-cost] reductions of the size of 
> struct rt_mutex (in include/linux/rt_lock.h), upon which all other 
> PI-aware locking objects are based. Right now it's 9 words, of which 
> struct plist is 5 words. Would be nice to trim this to 8 words - which 
> would give a nice round size of 32 bytes on 32-bit.

Why not make rt_mutex->wait_lock a pointer ? Set it to NULL and handle
it in rt.c .

Daniel

