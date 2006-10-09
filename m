Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWJITBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWJITBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWJITBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:01:53 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:2432 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964781AbWJITBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:01:53 -0400
Subject: Re: [PATCH 04/10] -mm: clocksource: add some new API calls
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061006185456.681979000@mvista.com>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.681979000@mvista.com>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 12:01:50 -0700
Message-Id: <1160420510.5458.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 11:54 -0700, Daniel Walker wrote:
> plain text document attachment (clocksource_user_api.patch)
> originally used plist but removed it in this patch, and used a sorted list 
> which is just as fast with a lot less memory overhead.
> 
> Introduces some new API calls,
> 
> - clocksource_get_clock()
> 	Allows a clock lookup by name.
> - clocksource_rating_change()
> 	Used by a clocksource to signal a rating change. Replaces 
> 	reselect_clocksource()

Adds ns2cyc interface. Just to keep things in logical chunks, maybe
would that chunk be better added with the patch that uses it?

> I also moved the the clock source list to a plist, which removes some lookup
> overhead in the average case.

Probably need to update the header, as you don't use a plist now. :)


> Signed-Off-By: Daniel Walker <dwalker@mvista.com>


Otherwise this patch looks like a good cleanup to me.

Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john




