Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTIZF0t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 01:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbTIZF0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 01:26:49 -0400
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:60800 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S261440AbTIZF0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 01:26:48 -0400
Date: Fri, 26 Sep 2003 07:26:37 +0200
From: Frank v Waveren <fvw@var.cx>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: How do I access ioports from userspace?
Message-ID: <20030926052636.GA15006@var.cx>
References: <20030925160351.E26493@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925160351.E26493@one-eyed-alien.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 04:03:51PM -0700, Matthew Dharm wrote:
> I'd like to be able to access some ioports to some custom hardware directly
> from userspace, without creating a specialized kernel-level driver.  Is
> there a way to do that?
Either use /dev/port, or if it's performance critical (but not performance
critical enough to do in kernelspace), use ioperm/iopl and inb/outb.


-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
