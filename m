Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTJEWTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbTJEWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:19:36 -0400
Received: from hacksaw.org ([66.92.70.107]:9139 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id S263921AbTJEWTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:19:33 -0400
Message-Id: <200310052219.h95MJQKF008980@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: swap and 2.4.20 
In-reply-to: Your message of "Sun, 05 Oct 2003 14:56:27 PDT."
             <20031005215627.GE1205@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 Oct 2003 18:19:26 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does this mean that you could replace a library out from under a running but 
> > largely paged out app, and have it suddenly switch to the new library?
> 
> Technically yes, but realistically no.
> 
> You'd more likely crash the app since maybe only a few pages of the new code
> were paged in, and nothing says that it's the update of the code you wanted...
> 

Ahh, so nothing is done to ensure that that functional dependencies are 
resolved. All right, that's not shocking, since it's not the point.

In fact, thinking about what might be involved to make that possible hurts my 
head. Well maybe not. I wonder if you could have a mechanism that causes the 
entire library to be paged out and reloaded if while paging the version is 
discovered to have changed.

In many ways this would be cool, as it would mean that running apps could stay 
up and yet get bugs fixed.

I'm guessing that would require there to be no static variables in the 
library, as well as being fully reentrant, or that that any statics are in a 
page whose format doesn't change and is locked down for the switch.
-- 
Listening is a craft.
Hearing is an art.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


