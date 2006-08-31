Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWHaHlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWHaHlw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWHaHlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:41:51 -0400
Received: from ns2.suse.de ([195.135.220.15]:45802 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751013AbWHaHlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:41:51 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Thu, 31 Aug 2006 09:41:40 +0200
User-Agent: KMail/1.9.3
Cc: "Badari Pulavarty" <pbadari@gmail.com>,
       "J. Bruce Fields" <bfields@fieldses.org>, petkov@math.uni-muenster.de,
       akpm@osdl.org, "lkml" <linux-kernel@vger.kernel.org>
References: <20060820013121.GA18401@fieldses.org> <1156974410.16136.1.camel@dyn9047017100.beaverton.ibm.com> <44F6AD47.76E4.0078.0@novell.com>
In-Reply-To: <44F6AD47.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608310941.40076.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 09:35, Jan Beulich wrote:
> Andi submitted a fix for this to Linus, but that's post-rc5. Jan

I assume you mean the fallback validation fix. Linus unfortunately
didn't merge any of my new patches yet :/

But did you ever work out why the stack backtrace completely restarted? 
I never got this. In theory the RSP gotten out of the unwind
context and used for the fallback should have been already near the end
and the old unwinder shouldn't have found much.

-Andi

P.S.: Badari, we worked out your kernel_math_context trace too:
that one is actually a gcc bug related to dubious unwind tables generated
for noreturn calls (in your case do_exit). We were still discussing the best 
workaround for that one.

