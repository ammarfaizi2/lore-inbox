Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263890AbUDFPzx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbUDFPzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:55:52 -0400
Received: from host24.tni.fr ([195.25.255.24]:39442 "HELO ender.tni.fr")
	by vger.kernel.org with SMTP id S263890AbUDFPzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:55:44 -0400
Subject: Re: {put,get}_user() side effects
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Andi Kleen <ak@muc.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4072CD22.4010603@backtobasicsmgmt.com>
References: <1HVGV-1Wl-21@gated-at.bofh.it>
	 <m3fzbhfijh.fsf@averell.firstfloor.org>
	 <1081261716.8318.7.camel@speedy.priv.grenoble.com>
	 <4072CD22.4010603@backtobasicsmgmt.com>
Content-Type: text/plain
Message-Id: <1081266434.8318.12.camel@speedy.priv.grenoble.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.6 
Date: Tue, 06 Apr 2004 17:47:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 08:30 -0700, Kevin P. Fleming wrote:
> Xavier Bestel wrote:
> 
> > Sorry, I read too fast. I didn't know sizeof could avoid side effects.
> > 
> 
> Both typeof and sizeof are compile-time constructs, so there is no 
> opportunity for any expression side effects to occur. Presumably one 
> could do:
> 
> typeof(1/0UL)
> 
> without ever causing the obvious side effect either (granted, this is a 
> pointless piece of code :-)).

Yeah, now that you tell it, it seems obvious when you consider macros
like min/max and friends which rely on typeof to avoid side-effects.


