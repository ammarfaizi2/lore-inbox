Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVHYV1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVHYV1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVHYV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:27:04 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54658 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932486AbVHYV1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:27:04 -0400
Message-ID: <430E37A0.1000304@nortel.com>
Date: Thu, 25 Aug 2005 15:26:56 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: linux-kernel@vger.kernel.org, tom.anderl@gmail.com
Subject: Re: [OT] volatile keyword
References: <Pine.LNX.4.58.0508251335280.4315@shell2.speakeasy.net> <430E30B2.1020700@nortel.com> <Pine.LNX.4.58.0508251414350.19866@shell2.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0508251414350.19866@shell2.speakeasy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:

> I figured it was something along these lines. In that case, is the
> following code (from kernel/posix-timers.c) really doing the right
> thing?
> 
> do
>     expires = timr->it_timer.expires;
> while ((volatile long) (timr->it_timer.expires) != expires);
> 
> Seems it's casting the value, not the pointer.

Someone else will have to give the definitive answer, but it looks 
suspicious to me...

Chris
