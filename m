Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTJJQm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTJJQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:42:27 -0400
Received: from holomorphy.com ([66.224.33.161]:50561 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263101AbTJJQmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:42:22 -0400
Date: Fri, 10 Oct 2003 09:44:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Mark Mielke <mark@mark.mielke.cc>, G?bor L?n?rt <lgb@lgb.hu>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts
Message-ID: <20031010164408.GF727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Mark Mielke <mark@mark.mielke.cc>, G?bor L?n?rt <lgb@lgb.hu>,
	Stuart Longland <stuartl@longlandclan.hopto.org>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	Fabian.Frederick@prov-liege.be, linux-kernel@vger.kernel.org
References: <20031009165723.43ae9cb5.skraw@ithnet.com> <3F864F82.4050509@longlandclan.hopto.org> <20031010125137.4080a13b.skraw@ithnet.com> <3F86BD0E.4060607@longlandclan.hopto.org> <20031010143529.GT5112@vega.digitel2002.hu> <20031010144723.GC727@holomorphy.com> <20031010144837.GB12134@mark.mielke.cc> <20031010150122.GD727@holomorphy.com> <20031010155007.GA13825@mark.mielke.cc> <3F86DFED.2030507@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F86DFED.2030507@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
>> Note that I didn't say that the software
>> approach could *guarantee* immediate success. You wouldn't unplug the
>> CPU until your had successfully deregistered the CPU from having anything
>> scheduled for it.
>> Is this not the way things (should) work?

On Fri, Oct 10, 2003 at 12:35:57PM -0400, Chris Friesen wrote:
> Note that if you're doing this for high availability purposes, you 
> already need to have some way of handling a cpu that just dies in the 
> middle of processing.  Once you've done that, you can just re-use that 
> to handle hot removal--it just gets treated like a fault.  This is not 
> to say that you can't try and shut it down nicely first, but its not a 
> hard requirement.

If you've lost the registers in-kernel, you can't even get away with
shooting the process. I'm not sure what extreme HA wants to do with
that, but at a such a point it's not really even possible to figure
out how to extract the thing from whatever critical section it may
have been in.


-- wli
