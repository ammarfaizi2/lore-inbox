Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031557AbWLAQUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031557AbWLAQUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936457AbWLAQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:20:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:1427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935227AbWLAQUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:20:30 -0500
Date: Fri, 1 Dec 2006 08:20:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Ben Collins <ben.collins@ubuntu.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
 hyper-threading.
In-Reply-To: <1164989436.3233.85.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0612010815510.3695@woody.osdl.org>
References: <11648607683157-git-send-email-bcollins@ubuntu.com> 
 <11648607733630-git-send-email-bcollins@ubuntu.com>  <20061201132918.GB4239@ucw.cz>
  <1164980500.5257.922.camel@gullible>  <1164983529.3233.73.camel@laptopd505.fenrus.org>
  <1164985757.5257.933.camel@gullible> <1164989436.3233.85.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Dec 2006, Arjan van de Ven wrote:
> 
> I would suggest you drop the patch; openssl has been long fixed, and it
> was only a theoretical attack in the first place...
> I'm not saying the attack isn't something that should be addressed.. but
> it is, and disabling hyperthreading is not the right fix.

I concur. A lot of these "timing attacks" may be slightly easier on HT 
CPU's than other CPU's, but they are still pretty damn theoretical (the 
more recent branch predictor one is even more so, since it apparently 
requires access to the branch predictor state itself, which you need 
CPL0 to get - and once you have CPL0, why the hell bother with the branch 
predictors at all, since you might as well just read the state directly 
from the process..)

People are a hell of a lot better at worrying about unrealistic attacks 
that they don't understand and thus sound scary, than about worrying about 
the simple things ("You mean my password shouldn't be my pets name, taped 
to my monitor? Really? And I wasn't supposed to give it out just because 
that nice man gave me chocolate?")

So I think people have blown those SSL timing attacks _way_ out of 
proportion, just because it sounds technical and cool. 

Besides, most of the time you can disable HT in the BIOS, which is better 
anyway if you don't want it.

		Linus
