Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbVLTQe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVLTQe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVLTQe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:34:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19453 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751123AbVLTQe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:34:26 -0500
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
In-Reply-To: <20051220143848.GA2053@elte.hu>
References: <43A5A7B5.21A4CAAE@tv-sign.ru>  <20051220143848.GA2053@elte.hu>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 08:34:21 -0800
Message-Id: <1135096463.3834.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 15:38 +0100, Ingo Molnar wrote:
> * Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > Rediff against patch-2.6.15-rc5-rt2.
> > 
> > Nothing was changed except s/plist_next_entry/plist_first_entry/ to 
> > match the current naming.
> 
> thanks Oleg, your patches look good to me, and it's a worthwile cleanup 
> to make plist.h ops behave more like normal list.h ops. The new ops 
> should be documented, but otherwise it looks OK.

I think there is a bug in the new plist_add() , which was in the
original code. It doesn't properly handle the new maximum node scenario,
or INT_MAX . 

If the list is 1 2 3 4

and you insert 5 , you'll end up with the list 1 2 3 5 4 . Or something
like that .


Daniel

