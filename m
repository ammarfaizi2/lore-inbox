Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHRUbK>; Sun, 18 Aug 2002 16:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSHRUbJ>; Sun, 18 Aug 2002 16:31:09 -0400
Received: from dsl-213-023-039-196.arcor-ip.net ([213.23.39.196]:51162 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316088AbSHRUbJ>;
	Sun, 18 Aug 2002 16:31:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: Generic list push/pop
Date: Sun, 18 Aug 2002 22:34:12 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.4.44.0208181326160.2499-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0208181326160.2499-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Message-Id: <E17gWkW-00032w-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 August 2002 21:28, you wrote:
> Hi,
> 
> On Sun, 18 Aug 2002, Daniel Phillips wrote:
> > #define push_list(_LIST_, _NODE_) \
> > 	_NODE_->next = _LIST_; \
> > 	_LIST_ =_NODE_;
> > 
> > #define pop_list(_LIST_) ({ \
> > 	typeof(_LIST_) _NODE_ = _LIST_; \
> > 	_LIST_ = _LIST_->next; \
> > 	_NODE_; })
> 
> How do we protect against:
> 
> push_list(getFuckingList(), node);
> node_t node = pop_list(getFuckingList());
> 
> ? Couldn't this break the _LIST_ = _LIST_->next; ?

Yes, there are various sloppy things there, including missing parens
around args and missing wrapper around the statement.  It should also
be written to evaluate each arg exactly once.  With all that done it
will be even uglier but at least it will work reliably.

-- 
Daniel

