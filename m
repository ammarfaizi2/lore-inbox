Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbTCZKmc>; Wed, 26 Mar 2003 05:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCZKmc>; Wed, 26 Mar 2003 05:42:32 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:13259 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261555AbTCZKmb>;
	Wed, 26 Mar 2003 05:42:31 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: adaplas@pol.net
Date: Wed, 26 Mar 2003 11:53:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
Cc: jsimmons@infradead.org,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <85019355E7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 03 at 11:42, Petr Vandrovec wrote:
> 
> accel_cursor unconditionally sets FB_CUR_SETPOS. Can you write it
> down to the TODO list to eliminate this? Cursor position lives 
> in different registers than cursor enable/disable on my hardware...
 
> And if we could rename FB_CUR_SETCUR to FB_CUR_SETVISIBILITY and
> leave cursor->enable setting on accel_cursor's caller, it would
> be even better.

I just noticed that softcursor.c contains copy of FB_CUR_SETCUR ->
cursor->enable code from accel_cursor(). Either 'enable' field has 
no bussiness in the fb_cursor structure (as it can be always infered from 
set flags, and if softcursor needs some internal bookkeeping, it should 
use some other variable and not fb_cursor's field), or this conversion 
should disappear from softcursor.c, and FB_CUR_SETCUR semantic should
change.
                                                Petr
                                                

