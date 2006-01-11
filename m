Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWAKTU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWAKTU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWAKTU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:20:58 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:22350 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751411AbWAKTU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:20:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q/eFWMt2ylblEL2F0VAyhAIHJSGl2UP6VMB58thwqQwvsUXQJFDgr6xnK4t3cDY9lfuYMRSiWcxfJIk/Q1FirUFJBEV2kEmIwsxjORQWmemGm8AujnhceVvgvMY+hb5sx7+Y2rmqsF8az0GSmreRdvlNo6roqK/nnGhcW7BcLrQ=  ;
Message-ID: <20060111192056.67364.qmail@web34113.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 11:20:56 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: Is user-space AIO dead?
To: David Lloyd <dmlloyd@tds.net>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0601111304390.14191@tomservo.workpc.tds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Lloyd <dmlloyd@tds.net> wrote:

> On Wed, 11 Jan 2006, Kenny Simpson wrote:
> 
> > --- David Lloyd <dmlloyd@tds.net> wrote:
> >> Wouldn't nonblocking I/O on regular files be nice?
> >
> > Yes it could be.  As I understand it, regular file writes (not O_DIRECT) 
> > are only to the page cache and only block when there is memory pressure 
> > (so it is more of a throttle).
> 
> If you were however using O_DIRECT or O_SYNC, you would then have a 
> mechanism to know when your writes have made it to disk, which might be 
> useful for transactional systems.

Right, but I'm not sure O_DIRECT implies stable storage, only data sent out to the device, not
held up in the page cache (I could be wrong).

AIO is implemented for O_DIRECT according to the paper, but they observed it not having benefit.

AIO being implemented to O_SYNC would be nice for my use, as it would also eliminate the extra
alignment restrictions brought on by O_DIRECT.

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
