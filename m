Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbTDFBQw (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 20:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbTDFBQw (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 20:16:52 -0500
Received: from hibernia.jakma.org ([212.17.36.87]:50312 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262749AbTDFBQv (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 20:16:51 -0500
Date: Sun, 6 Apr 2003 02:28:19 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to fix the ptrace flaw without rebooting
In-Reply-To: <1049454936.2150.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0304060225280.4645-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Apr 2003, Alan Cox wrote:

> Thats not a sufficient fix except for people blindly running the
> example exploit

Also, removing CAP_SYS_PTRACE from the capability bounded set does
not close the hole (well, as shown by the exploit) either. It seems
CAP_SYS_PTRACE only closes the case of PTRACE_ATTACH, all other
ptrace()'s work, eg PTRACE_TRACEME -> strace echo foo and the exploit 
works too.

Should CAP_SYS_PTRACE not do as the name suggests and completely 
disallow ptrace()? (not just PTRACE_ATTACH).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
An egghead is one who stands firmly on both feet, in mid-air, on both
sides of an issue.
		-- Homer Ferguson

