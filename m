Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275146AbRIYSdr>; Tue, 25 Sep 2001 14:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275141AbRIYSdk>; Tue, 25 Sep 2001 14:33:40 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:55766 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S274586AbRIYSd1>; Tue, 25 Sep 2001 14:33:27 -0400
Message-ID: <3BB0CE31.2446D3F9@kegel.com>
Date: Tue, 25 Sep 2001 11:34:25 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lemon <jlemon@flugsvamp.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <local.mail.linux-kernel/3BAEB39B.DE7932CF@kegel.com>
		<local.mail.linux-kernel/3BAF83EF.C8018E45@distributopia.com> <200109251736.f8PHamf40636@prism.flugsvamp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lemon wrote:
> 
> In article <local.mail.linux-kernel/3BB03C6A.7D1DD7B3@kegel.com> you write:
> >Right, and kqueue() can't even represent the 'level triggered' style --
> >or at least it isn't clear from the paper that it can!  
>
> Yes it does - kqueue() is 'level-triggered' by default.  

Apologies for the line noise.  I've corrected 
http://www.kegel.com/c10k.html to show kqueue as both edge- and level- triggered.
Further corrections welcome...

> As Christopher pointed out, any event can be converted into an
> edge-triggered style notification simply by setting EV_CLEAR.  However,
> this is not usually a popular model from a programmer's point of view,
> as it increases the complexity of their app.  (This is what I've seen, YMMV)

Agreed; the poll()-like semantics of level-triggering are particularly
forgiving.

- Dan
