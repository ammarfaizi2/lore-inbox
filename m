Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVG0BNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVG0BNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVG0BNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:13:44 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:22654 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262306AbVG0BNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:13:43 -0400
Message-ID: <42E6DFD2.6050101@m1k.net>
Date: Tue, 26 Jul 2005 21:13:54 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: astralstorm@gorzow.mm.pl, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>	<42E692E4.4070105@m1k.net>	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>	<42E69C5B.80109@m1k.net>	<20050726144149.0dc7b008.akpm@osdl.org>	<42E6D7E9.2080408@m1k.net> <20050726180452.3bdec6df.akpm@osdl.org>
In-Reply-To: <20050726180452.3bdec6df.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>>However, sometimes there are patches in -mm that are incompatable with 
>>-linus.  An example of this is "Pavel's pm_message_t mangling" ... 
>>    
>>
>OK.  The way I handle an exceptional case like that is to merge the
>-linus-compatible patch into -mm and then have another patch on top of that
>which fixes things up for the -mm tree.  Later, that patch gets folded into
>your patch if Pavel's stuff gets merged.  Or gets dropped if it doesn't get
>merged.  Or gets folded into Pavel's stuff if your patch goes in first.
>
>IOW: for a bunch of reasons we really do want to make the "fix up V4l for
>-mm differences" patch be a separate patch file.
>
>And I very much prefer that people work against -linus and when these
>things occasionally pop up I'll just fix stuff up.  It's only if someone is
>explicitly working against a patch which is only in -mm that they should
>have to care about -mm vs -linus differences.
>
I think you may have misunderstood me here.  v4l didnt make the 
patches... You (akpm) did... We included them in our cvs when you merged 
them into -mm:

add-type-checking-to-pm_message_t-bttv-fix.patch added to -mm tree
add-type-checking-to-pm_message_t-tuner-core-fix.patch added to -mm tree
add-type-checking-to-pm_message_t-msp-fix.patch added to -mm tree
add-type-checking-to-pm_message_t-tda9887-fix.patch added to -mm tree

Trust me, nobody did anything wrong here, and everything that needs to 
be done with regards to this is already done, AFAIK.

I'm just saying it would be handy for the cvs to be able to compile 
separately with both -mm and -linus trees automatically.  I just sent 
you a patch that solves the issue.

-- 
Michael Krufky

