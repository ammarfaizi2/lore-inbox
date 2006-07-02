Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWGBIVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWGBIVf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 04:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWGBIVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 04:21:34 -0400
Received: from web32013.mail.mud.yahoo.com ([68.142.207.110]:12173 "HELO
	web32013.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751881AbWGBIVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 04:21:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iiXwkYFQ90Z+++iDjJc9pwJw1rfBS6BF00x/q1ef8YwO/GH2qw7xdhoO5/cdAASBzvx00j1i7xdlxeMKQMugqT1/Qg3h9xXMbYi9WMcFxWAR4rPwf4WeNSYEKzYpSZlYvCOIyFCe5FRjm664auH3nq4dFB/fpm5iO1lt+KAgoGk=  ;
Message-ID: <20060702082133.23309.qmail@web32013.mail.mud.yahoo.com>
Date: Sun, 2 Jul 2006 01:21:33 -0700 (PDT)
From: Congjun Yang <congjuny@yahoo.com>
Subject: Re: keyboard raw mode
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
In-Reply-To: <200607011004.01317.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9-22.EL(CentOS 4.2) is what I currently use.
2.4.20 was where I first saw, in keyboard.c, the
workaround that throws away a second break code.

I think I like the new design for the user input
system: separate the protocol layer from the raw port.
But, would it be nice for the atkbd driver to still
provide a raw (or passthrough) mode?

Thanks,
Congjun Yang

--- Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Saturday 01 July 2006 05:55, Jan-Benedict Glaw
> wrote:
> >   * All protocol drivers (eg. the atkbd driver)
> will *never* ever
> >     stuff the raw I/O anywhere.
> 
> Actually some of them do via EV_MSC/MSC_RAW events.
> So raw code should be
> available through evdev nodes and also on x86
> keyboard driver in raw mode
> should also pass raw data through (from atkbd only).
> 
> Congjun, what 2.6.x kernel have you tried?
> 
> -- 
> Dmitry
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
