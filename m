Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSHRTYE>; Sun, 18 Aug 2002 15:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSHRTYE>; Sun, 18 Aug 2002 15:24:04 -0400
Received: from pD9E23924.dip.t-dialin.net ([217.226.57.36]:27267 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315720AbSHRTYD>; Sun, 18 Aug 2002 15:24:03 -0400
Date: Sun, 18 Aug 2002 13:28:00 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Generic list push/pop
In-Reply-To: <E17gVcL-00031m-00@starship>
Message-ID: <Pine.LNX.4.44.0208181326160.2499-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 18 Aug 2002, Daniel Phillips wrote:
> #define push_list(_LIST_, _NODE_) \
> 	_NODE_->next = _LIST_; \
> 	_LIST_ =_NODE_;
> 
> #define pop_list(_LIST_) ({ \
> 	typeof(_LIST_) _NODE_ = _LIST_; \
> 	_LIST_ = _LIST_->next; \
> 	_NODE_; })

How do we protect against:

push_list(getFuckingList(), node);
node_t node = pop_list(getFuckingList());

? Couldn't this break the _LIST_ = _LIST_->next; ?

JAQ...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

