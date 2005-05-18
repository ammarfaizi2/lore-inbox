Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVERWGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVERWGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVERWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:06:09 -0400
Received: from graphe.net ([209.204.138.32]:51980 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262401AbVERWFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:05:44 -0400
Date: Wed, 18 May 2005 15:05:39 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Optimize sys_times for a single thread process
In-Reply-To: <428B09A6.DD188E8D@tv-sign.ru>
Message-ID: <Pine.LNX.4.62.0505181503520.10958@graphe.net>
References: <428B09A6.DD188E8D@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2005, Oleg Nesterov wrote:

> Christoph Lameter wrote:
> >
> > +#ifdef CONFIG_SMP
> > +		if (current == next_thread(current)) {
> > +			/*
> > +			 * Single thread case without the use of any locks.
> 
> A nitpick, but wouldn't be it clearer to to use
> thread_group_empty(current)?

The thread ist needs to contain only one element which is current.
thread_group_empty checks for no threads.

Do we need a new macro?

