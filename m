Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTI3Ht7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTI3Ht7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:49:59 -0400
Received: from diesel.grid4.com ([208.49.116.17]:20918 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S261190AbTI3Ht5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:49:57 -0400
Date: Tue, 30 Sep 2003 03:50:24 -0400
From: Paul <set@pobox.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20030930075024.GA1620@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch> <20030929151643.GA15992@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929151643.GA15992@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz>, on Mon Sep 29, 2003 [05:16:43 PM] said:
> On Sun, Sep 28, 2003 at 10:59:02AM +0200, Roger Luethi wrote:
> 
> > With test6, keyboard repeat takes very noticably longer to kick in after X
> > has been started (for both X and console). In test5, starting X makes no
> > difference.
> 
> Bug in repeat rate setting code. Thanks for reporting, this should fix
> it:
> 
	Hi;

	I applied this patch to 2.6.0-test6, but the delay before
repeat kicks in is slower than previous versions. It seems more like
the latest 2.4 kernel. Note, this isnt the speed of the repeat, but
the delay before it kicks in. Havent tested unpatched test6.
	On the other hand, the mouse pointer (ps/2) has been kicked
into overdrive. much faster than test5 and latest 2.4.
	Also, I think that the requirement to enable gameport in
the input section to get access to some alsa sound drivers is
a bug. Ive looked at the source to some, and they #ifdef around
gameport support. test5 didnt have this problem for my 1371 driver.

Paul
set@pobox.com
	
