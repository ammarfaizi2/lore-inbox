Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVF2PMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVF2PMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVF2PMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:12:41 -0400
Received: from mail1.kontent.de ([81.88.34.36]:9920 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261329AbVF2PMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:12:38 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: kmalloc without GFP_xxx?
Date: Wed, 29 Jun 2005 17:12:55 +0200
User-Agent: KMail/1.8
Cc: rostedt@goodmis.org, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200506291402.18064.vda@ilport.com.ua> <Pine.LNX.4.58.0506290927370.22775@localhost.localdomain> <200506291714.32990.vda@ilport.com.ua>
In-Reply-To: <200506291714.32990.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291712.55893.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. Juni 2005 16:14 schrieb Denis Vlasenko:
> This is more or less what I meant. Why think about each kmalloc and when you
> eventually did get it right: "Aha, we _sometimes_ get called from spinlocked code,
> GFP_ATOMIC then" - you still do atomic alloc even if cases when you
> were _not_ called from locked code! Thus you needed to think longer and got
> code which is worse.

And if not? GFP_NOFS and GFP_NOIO exist for a reason.

	Regards
		Oliver
