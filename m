Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266092AbUAFHsE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 02:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266093AbUAFHsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 02:48:04 -0500
Received: from [216.239.30.242] ([216.239.30.242]:2058 "EHLO wind.enjellic.com")
	by vger.kernel.org with ESMTP id S266092AbUAFHr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 02:47:57 -0500
Message-Id: <200401060747.i067lr5S030638@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Tue, 6 Jan 2004 01:47:53 -0600
In-Reply-To: Philip Dodd <spambox@two-towers.net>
       "2.4.24 and exec-shield-2.4.23-G4" (Jan  5,  9:36pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Philip Dodd <spambox@two-towers.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 and exec-shield-2.4.23-G4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 5,  9:36pm, Philip Dodd wrote:
} Subject: 2.4.24 and exec-shield-2.4.23-G4

> Hi all,

Good evening, hope the day is going well for everyone.

> Just a quick query - I rebuilt the kernel on one of the machines here 
> and I was running the previous 2.4.23 with Ingo's exec-shield patch.  I 
> got the same patch (2.4.23-G4) to apply pretty easily (the mmremap hunk 
> applied with an offset, only the makefile failed, patched by hand) and 
> was just wondering if it is reasonable to assume the mmremap patch in 
> 2.4.24 won't impact the exec-shield patch.  The patch in question is 
> attached here.
> 
> I'm a bit of a neopyhte, but a quick look through the code didn't 
> suggest that it would have any leathal effect.  Am I wrong and will my 
> PC catch fire overnight because of this? :-D

The preliminary indications I have indicate there are problems.

I applied the 2.4.23-G4 patch from Ingo with the same results you had,
ie the the mmremap offset and Makefile failures.  Compiled and
rebooted the kernel on a test machine.

XFree86 4.3.0 with the RedHat patches now fails to start with a SIG11
error.  Turning off exec-shield (echoing 0 to
/proc/sys/kernel/exec-shield) enables XFree to start normally.

So it would seem that something changed with the mremap changes in
2.4.24.

> Thanks in advance,
> 
> Phil

Have a good day.

Greg

}-- End of excerpt from Philip Dodd

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-1686
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"The POP3 server service depends on the SMTP server service, which failed
to start because of the following error:  The operation completed
succesfully."
                                -- Windows NT server v3.51
