Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWH1Oyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWH1Oyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbWH1Oyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:54:40 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:5764 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751047AbWH1Oyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:54:39 -0400
Date: Mon, 28 Aug 2006 07:54:36 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH RFC 3/6] Use %gs as the PDA base-segment in the kernel.
Message-ID: <20060828145436.GA5710@lucon.org>
References: <20060827084417.918992193@goop.org> <200608271757.18621.ak@suse.de> <44F1D464.5020304@goop.org> <200608272019.15067.ak@suse.de> <44F2D8A4.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F2D8A4.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 10:51:00AM +0100, Jan Beulich wrote:
> >>> Andi Kleen <ak@suse.de> 27.08.06 20:19 >>>
> >On Sunday 27 August 2006 19:20, Jeremy Fitzhardinge wrote:
> >> Andi Kleen wrote:
> >> >> +1:	movw GS(%esp), %gs
> >> >>     
> >> >
> >> > movl is recommended in 32bit mode
> >> >   
> >> 
> >> arch/i386/kernel/entry.S: Assembler messages:
> >> arch/i386/kernel/entry.S:334: Error: suffix or operands invalid for `mov'
> >
> >Looks like a gas bug to me.
> 
> This was an intentional change (by H.J. if I recall right) as using movl
> with segment registers gives the incorrect impression that one gets a
> 32-bit memory access (especially for stores this is important, since
> there's really nothing stored to the upper 16 bits). One should always
> use suffix-less 'mov' for segment register accesses.

mov will generate the optimal opcode with old and new assemblers.


H.J.
