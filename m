Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270649AbTG0CTT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 22:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270650AbTG0CTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 22:19:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:60044
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270649AbTG0CTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 22:19:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@arcor.de>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 12:38:37 +1000
User-Agent: KMail/1.5.2
Cc: ed.sweetman@wmich.edu, eugene.teo@eugeneteo.net,
       linux-kernel@vger.kernel.org
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307271046.30318.phillips@arcor.de> <20030726113522.447578d8.akpm@osdl.org>
In-Reply-To: <20030726113522.447578d8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307271238.37918.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 04:35, Andrew Morton wrote:
> It is interesting that Felipe says that stock 2.5.69 was the best CPU
> scheduler of the 2.5 series.  Do others agree with that?

Well this had the original tuning settings of 2 seconds for max sleep avg and 
starvation limit, and 95% for child penalty, which are the 2.4 O(1) settings. 
Interestingly, they are also what Ingo has put into the G3 patch (except for 
starvation limit), and account for a large part of the improvement in G3 as 
well as the increased resolution.

> And what about the O(1) backports?  RH and UL and -aa kernels?  Are people
> complaining about those kernels?  If not, why?  What is different?

No, this is what I have been trying to figure out; why is it that if we put 
all the settings the same as 2.4 that it doesn't perform as nicely. 2.5/6 
with the old settings is certainly better than with the vanilla settings, but 
not as good as 2.4 O(1). It does not appear to be scheduler alone, but the 
architectural changes to 2.5 that have changed interactivity are here to 
stay, and improving the interactivity estimator in the scheduler does help it 
anyway. It also gives us a chance to address certain corner cases that have 
always existed.

Con

