Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbULQIHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbULQIHC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 03:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbULQIHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 03:07:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:65503 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262765AbULQIG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 03:06:59 -0500
Date: Fri, 17 Dec 2004 09:06:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Significance of do ... while (0)
In-Reply-To: <Pine.LNX.4.58.0412162354030.26987@shell3.speakeasy.net>
Message-ID: <Pine.LNX.4.61.0412170903020.28145@yvahk01.tjqt.qr>
References: <41C25BDC.8080404@globaledgesoft.com> <20041217042911.GH76532@gaz.sfgoth.com>
 <Pine.LNX.4.61.0412170843530.14529@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0412162354030.26987@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >>    Can any one explain the importance of do  ... while (0)
>> >It's a standard C programming practice; more info is available from
>> Why? {} would suffice, no need to do{}while(0)
>
>Unless I'm mistaken, it won't work in all cases. Example:
>    #define foo(...) { ... /* nefarious macro stuff here */ ... }
>    if (some_condition)
>        foo();
>    else
>        // do something nifty
>
>The above would expand to:
>
>    if (some_condition) {
>        /* nefarious macro stuff here */
>    };
>    else
>        // do something nifty
>
>And that's not quite right.

So it's best to always make some braces around ifs :)
Would be consistent with longer-than-one-statement blocks too.

if(some_cond) {
	MY_MACRO
}



Jan Engelhardt
-- 
ENOSPC
