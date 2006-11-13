Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755297AbWKMR4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbWKMR4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbWKMR4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:56:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37486 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1755297AbWKMR4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:56:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UaPHG1BWGlKZKN3Es6WceXQ3xnc8yYYh1O+XC3PGX9TZME0kRPVqnz2e7HCWTUv5Gb4zI+Nyz9MobqM/9lFB15s91OkhGcEWc7aqmt+1rpSVfrOHrbiEVoTl6SnhVva164QHVPiTr8ntpWKkEw5LoWM+Vw9c593WvCRR2gIE3v4=
Message-ID: <82ecf08e0611130956m9f30bf0t2a7b62307d5f70ca@mail.gmail.com>
Date: Mon, 13 Nov 2006 13:56:04 -0400
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Paul Mundt" <lethal@linux-sh.org>, "David Brownell" <david-b@pacbell.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Andrew Victor" <andrew@sanpeople.com>,
       "Bill Gatliff" <bgat@billgatliff.com>,
       "Haavard Skinnemoen" <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       "Kevin Hilman" <khilman@mvista.com>, "Nicolas Pitre" <nico@cam.org>,
       "Russell King" <rmk@arm.linux.org.uk>,
       "Tony Lindgren" <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
In-Reply-To: <20061113173800.GA19553@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611111541.34699.david-b@pacbell.net>
	 <20061113173800.GA19553@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, some ideas:

> I'm not convinced that exposing the pin number to drivers is the way to
> go. The pin numbers themselves are rarely portable across "similar" CPUs
> with identical peripherals, while the pin function itself may be
> portable (or simply unecessary).

I guess that a kind of "name addressing" would be the way to go, we
need to get to it by "location" (I'm thinking PortA 20, PortB 5 rather
than pin number or some other arbitrary convention; we need a way to
not need to look up what 'Port X pin B' should be called.

> Pin muxing also needs to be handled in a
> much more transparent and intelligent fashion, which is something else
> that is fairly easy to do when looking at a symbolic name for the pin
> function rather than the pin # itself.

Seconded

> Any API also needs to allow for multiple GPIO controllers, as it's rarely
> just the CPU that has these or needs to manipulate them.

Agreed, but maybe 'not now'

Another thing that may be considered is the ability to get 'pointers'
for GPIOs. And, of course, protecting GPIOs from concurrent accesses

-- 
-
Thiago Galesi
