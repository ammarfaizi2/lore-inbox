Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274237AbUKBGiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274237AbUKBGiH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUKBGiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:38:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:52981 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S783090AbUKBGh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:37:59 -0500
Message-ID: <41872B2E.6020902@nortelnetworks.com>
Date: Tue, 02 Nov 2004 00:37:34 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-os@analogic.com, dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>  <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com>  <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <41826A7E.6020801@domdv.de> <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com> <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org> <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com> <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org> <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com> <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org> <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com> <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Intel, if I recall correctly, rdtsc is totally serializing, so you're
> testing not just the instructions between the rdtsc's, but the length of
> the pipeline, and the time it takes for stuff around it to calm down.  

Actually, the Intel docs say that rdtsc is not serializing (specifically for the 
P6 series, but linked off the P4 section of the site) and their sample 
performance measuring code for the P4 shows it using a serializing instruction 
before the call to rdtsc.

Chris
