Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbTJJQi1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbTJJQi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:38:27 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9106 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263083AbTJJQiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:38:22 -0400
Message-ID: <3F86DFED.2030507@nortelnetworks.com>
Date: Fri, 10 Oct 2003 12:35:57 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Mielke <mark@mark.mielke.cc>
Cc: William Lee Irwin III <wli@holomorphy.com>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be> <20031009115809.GE8370@vega.digitel2002.hu> <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010144837.GB12134@mark.mielke.cc> <20031010150122.GD727@holomorphy.com> <20031010155007.GA13825@mark.mielke.cc>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:

> Note that I didn't say that the software
> approach could *guarantee* immediate success. You wouldn't unplug the
> CPU until your had successfully deregistered the CPU from having anything
> scheduled for it.
> 
> Is this not the way things (should) work?

Note that if you're doing this for high availability purposes, you 
already need to have some way of handling a cpu that just dies in the 
middle of processing.  Once you've done that, you can just re-use that 
to handle hot removal--it just gets treated like a fault.  This is not 
to say that you can't try and shut it down nicely first, but its not a 
hard requirement.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

