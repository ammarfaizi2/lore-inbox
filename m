Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUDFS2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbUDFS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:28:44 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:6125 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263942AbUDFS2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:28:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16498.63185.267645.387612@gargle.gargle.HOWL>
Date: Tue, 6 Apr 2004 14:28:33 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: <20040406180443.41252.qmail@web40502.mail.yahoo.com>
References: <200404061606.i36G6YLE003375@eeyore.valparaiso.cl>
	<20040406180443.41252.qmail@web40502.mail.yahoo.com>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sergiy" == Sergiy Lozovsky <serge_lozovsky@yahoo.com> writes:

>> Policy has no place inside the kernel.

Sergiy> Root privileges (ability to send a signal to any process,
Sergiy> access any file and so on) are encoded in the kernel.

But that does not require a LISP interpreter in the kernel either.
And you are also mistaking policy with a capability.  Who has root is
a policy, what root can do is a capability.  They are seperate issues.

Sergiy> So all interaction with the kernel goes via VM.  Investing
Sergiy> some time into carefull parameter check in VM allows to avoid
Sergiy> the same work for each new application.

You have not given us a simple example of how this VM would be used in
the kernel and what it provides.  I think that would help people
understand why you think this is so needed.

So just start with a process, explain how it wants to do some
restricted action, and how your VM would be required to mediate that
access.  Some simple flow charting and explaining of what steps would
happen and why would be a big help.

Personally, I think you're completely confusing policy with
capabilities.  Since the setting of policy is completely a user-space
issue, while the checking of capabilities is handled in the kernel.
And if the capability check requires a VM to do some mediation, that
capability check gets pushed out to userspace, instead of kept in the
VM in the kernel like you seem to want.  

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-952-7548
