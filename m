Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262794AbSIPTfK>; Mon, 16 Sep 2002 15:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSIPTfK>; Mon, 16 Sep 2002 15:35:10 -0400
Received: from dsl-213-023-040-192.arcor-ip.net ([213.23.40.192]:45449 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262794AbSIPTfJ>;
	Mon, 16 Sep 2002 15:35:09 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Mon, 16 Sep 2002 21:40:12 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209161335480.342-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209161335480.342-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <E17r1jA-0000MA-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 21:36, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 16 Sep 2002, Daniel Phillips wrote:
> > On Monday 16 September 2002 20:35, Thunder from the hill wrote:
> > > !assert(typeof((fool)->next) == typeof(fool));
> > 
> > You meant:
> > 
> > 	assert(typeof((fool)->next) != typeof(fool));
> 
> No, I mean "Never assert that the one next to a fool must be a fool, 
> either. You might be wrong."

A proper assert does not return a value, by definition.  It relies purely
on side effects, that is, it causes a screeching halt if the logical
expression was false.  It's always wrong to use an asssert in an expression,
and since BUG_ON is just assert(!expression) this applies to BUG_ON as
well.  The compiler should prevent you from making this mistake.

What I *thought* you meant was: "if the next fool that comes along is
exactly the same as the last fool, run away screaming".  There's some wisdom
in that.

-- 
Daniel
