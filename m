Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWE3Rp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWE3Rp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWE3RpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:45:25 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:47318 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932360AbWE3RpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:45:25 -0400
Subject: Re: [patch 06/61] lock validator: add __module_address() method
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
In-Reply-To: <20060529183325.b2f02192.akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <20060529212333.GF3155@elte.hu>
	 <20060529183325.b2f02192.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:45:10 -0400
Message-Id: <1149011110.12492.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 18:33 -0700, Andrew Morton wrote:

> 
> I'd suggest that __module_address() should do the same thing, from an API neatness
> POV.  Although perhaps that's mot very useful if we didn't take a ref on the returned
> object (but module_text_address() doesn't either).
> 
> Also, the name's a bit misleading - it sounds like it returns the address
> of a module or something.  __module_any_address() would be better, perhaps?

How about __valid_module_address()  so that it describes exactly what it
is doing. Or __module_address_valid().

-- Steve

> 
> Also, how come this doesn't need modlist_lock()?


