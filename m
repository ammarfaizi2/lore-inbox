Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVHZPe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVHZPe3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVHZPe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:34:28 -0400
Received: from web33308.mail.mud.yahoo.com ([68.142.206.123]:33967 "HELO
	web33308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965079AbVHZPe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:34:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G3C5miNmvxc9okDSM4tpxoJY5B8WLh+VGw89bF1ALamZpXp4eHQlnlfrz5rYkeS1ibvsrC7mgYq1l4Ua9d0R9KofqQlWrcJam6TUu/l7BBv5f8OyKbEWZyR5lJ4QQcPeDLSG7NWwsVyVue1RcOXTds7lvHpjfwkRIvUti0KloNw=  ;
Message-ID: <20050826153414.9643.qmail@web33308.mail.mud.yahoo.com>
Date: Fri, 26 Aug 2005 08:34:14 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050826131750.GG6471@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Aug 22, 2005 at 08:41:11AM -0700,
> Danial Thom wrote:
> >...
> > 
> > The issue I have with that logic is that you
> seem
> > to use "kernel" in a general sense without
> regard
> > to what its doing. Dropping packets is always
> > detrimental to the user regardless of what
> he's
> > using the computer for. An audio stream that
> > drops packets isn't going to be "smooth" at
> the
> > user level.
> 
> 
> That's not always true.
> 
> Imagine a slow computer with a GBit ethernet
> connection, where the user 
> is downloading files from a server that can
> utilize the full 
> network connection while listening to music
> from his local disk with 
> XMMS.
> 
> In this case, the audio stream is not depending
> on the network 
> connection. And the user might prefer dropped
> packages over a stuttering 
> XMMS.
> 
Audio connections are going to be windowed/flowed
in some way (thats how the internet works) so
you're not dealing with real capacity issues in
that example. You're not going to overrun your
ethernet adapter with an application; the issue
is running applications on servers that are also
doing a lot of other things. You can't isolate a
particular application at the device level, so
you drop packets randomly; not just ones you
don't care about. If your application can't run
well on your machine without dropping real
traffic, then you need a faster machine, not an
OS that compensates in a negative way.

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
