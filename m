Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWEHUaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWEHUaG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWEHUaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:30:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:30983 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750744AbWEHUaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:30:05 -0400
Date: Mon, 8 May 2006 22:30:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile error for 2.6.17-rc3-git15
Message-ID: <20060508203000.GC5467@mars.ravnborg.org>
References: <445FA8CF.9080405@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <445FA8CF.9080405@lwfinger.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 03:23:43PM -0500, Larry Finger wrote:
> After updating to 2.6.17-rc3-git15 
> (6810b548b25114607e0814612d84125abccc0a4f) and using gcc V4.0.2, I get the 
> following compile error:
> 
> HOSTCC  scripts/mod/modpost.o
> scripts/mod/modpost.c: In function ?check_sec_ref?:
> scripts/mod/modpost.c:716: error: cast to union type from type not present 
> in union
> 
> Using git bisect, I find that bed7a560333d40269a886c4421d4c8f964a32177 is 
> first bad commit.
The above is the merge of the kbuild changes.
The real offender is: c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed

Reverting this will fix it.

	Sam
