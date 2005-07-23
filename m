Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVGWKv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVGWKv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 06:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVGWKv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 06:51:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47532 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261334AbVGWKvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 06:51:16 -0400
Date: Sat, 23 Jul 2005 12:50:45 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Arjan van de Ven <arjan@infradead.org>
cc: Nishanth Aravamudan <nacc@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: Re: [PATCH] Add schedule_timeout_{interruptible,uninterruptible}{,_msecs}()
 interfaces
In-Reply-To: <1122078715.5734.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507231247460.3743@scrub.home>
References: <20050707213138.184888000@homer>  <20050708160824.10d4b606.akpm@osdl.org>
  <20050723002658.GA4183@us.ibm.com> <1122078715.5734.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 22 Jul 2005, Arjan van de Ven wrote:

> Also I'd rather not add the non-msec ones... either you're raw and use
> HZ, or you are "cooked" and use the msec variant.. I dont' see the point
> of adding an "in the middle" one. (Yes this means that several users
> need to be transformed to msecs but... I consider that progress ;)

What's wrong with using jiffies? It's simple and the current timeout 
system is based on it. Calling it something else doesn't suddenly give you 
more precision.

bye, Roman
