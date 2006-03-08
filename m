Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWCHEpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWCHEpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 23:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWCHEpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 23:45:04 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:37211 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750769AbWCHEpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 23:45:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: joe.korty@ccur.com
Subject: Re: Fw: Re: oops in choose_configuration()
Date: Tue, 7 Mar 2006 23:44:59 -0500
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200603071657_MC3-1-BA0F-6372@compuserve.com> <Pine.LNX.4.64.0603071648430.32577@g5.osdl.org> <20060308042841.GA16822@tsunami.ccur.com>
In-Reply-To: <20060308042841.GA16822@tsunami.ccur.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072344.59864.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 23:28, Joe Korty wrote:
> On Tue, Mar 07, 2006 at 04:57:39PM -0800, Linus Torvalds wrote:
> 
> > Well, snprintf() should be safe, though. It will warn if the caller is 
> > lazy, but these days, the thing does
> > 
> > 	max(buf_size - len, 0)
> > 
> > which should mean that the input layer passes in 0 instead of a negative 
> > number. And snprintf() will then _not_ print anything. 
> 
> I assume this is a typo, and you meant scnprintf?  AFAIK, snprintf has
> the same ol' bad behavior when #bytes-to-be-written > #bytes-in-buffer.
> 

No, we do want to know if output was truncated or not so snprintf is used.

-- 
Dmitry
