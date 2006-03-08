Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWCHE3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWCHE3o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWCHE3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:29:44 -0500
Received: from users.ccur.com ([66.10.65.2]:12239 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S1751288AbWCHE3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:29:44 -0500
Date: Tue, 7 Mar 2006 23:28:41 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: oops in choose_configuration()
Message-ID: <20060308042841.GA16822@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:57:39PM -0800, Linus Torvalds wrote:

> Well, snprintf() should be safe, though. It will warn if the caller is 
> lazy, but these days, the thing does
> 
> 	max(buf_size - len, 0)
> 
> which should mean that the input layer passes in 0 instead of a negative 
> number. And snprintf() will then _not_ print anything. 

I assume this is a typo, and you meant scnprintf?  AFAIK, snprintf has
the same ol' bad behavior when #bytes-to-be-written > #bytes-in-buffer.

Joe
