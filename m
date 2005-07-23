Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVGWNaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVGWNaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVGWNaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 09:30:06 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7854 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261365AbVGWNaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 09:30:04 -0400
Date: Sat, 23 Jul 2005 15:29:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <1122124324.3582.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507231524430.3743@scrub.home>
References: <20050707213138.184888000@homer>  <20050708160824.10d4b606.akpm@osdl.org>
 <20050723002658.GA4183@us.ibm.com>  <1122078715.5734.15.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507231247460.3743@scrub.home>  <1122116986.3582.7.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507231340070.3743@scrub.home>  <1122123085.3582.13.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507231456000.3728@scrub.home> <1122124324.3582.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 23 Jul 2005, Arjan van de Ven wrote:

> jiffies/HZ is the more powerful API. The msec one which also sets
> current to (un)interruptible is the simplified wrapper on top.

So why do you want to hide it? Make the jiffies based API the primary one 
and add some convenience functions, where we BTW could convert already 
constants at compile time.

bye, Roman
