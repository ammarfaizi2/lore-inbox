Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292870AbSC0WAn>; Wed, 27 Mar 2002 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSC0WAd>; Wed, 27 Mar 2002 17:00:33 -0500
Received: from mnh-1-14.mv.com ([207.22.10.46]:10765 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S292841AbSC0WA2>;
	Wed, 27 Mar 2002 17:00:28 -0500
Message-Id: <200203272202.RAA04496@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Corey Minyard <minyard@acm.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Threads performance - allow signal handler to not call handler 
In-Reply-To: Your message of "Wed, 27 Mar 2002 15:46:01 CST."
             <3CA23D99.6030900@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Mar 2002 17:02:44 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minyard@acm.org said:
> With this patch, if the flag is set, the signal handler  won't get
> called (thus saving the overhead of going in and out of  userland for
> the handler), but it will still wake up sigsuspend() and  select(). 

I've wanted this for UML as well.  I have some empty signal handlers which
exist for no reason other than to wake up pause/sigsuspend/et al.

				Jeff

