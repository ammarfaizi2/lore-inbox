Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbTHZQ0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbTHZQ0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:26:45 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:51383 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262891AbTHZQ0n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:26:43 -0400
Subject: Re: authentication / encryption key retention
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <11490.1061892774@redhat.com>
References: <Pine.LNX.4.44.0308221044470.20736-100000@home.osdl.org>
	 <11490.1061892774@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061915194.23880.218.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2003 12:26:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 06:12, David Howells wrote:
> > But some parts of the kernel might look at only the process-local keys 
> > ("does this process have rights to do that?")
> 
> Why? If a process has access to appropriate UID-level or GID-level keys, then
> surely it has the rights to do "that", even if it hasn't copied them into its
> process level keyring...

Because not every process that runs under your identity should have your
full set of rights.  You should be able to confine a given process based
on more than just the associated user identity, e.g. the role and
clearance in which the user is operating, the function and
trustworthiness of the program that the process is executing, etc. 
Otherwise, you have no protection against flawed or malicious programs
executed from any of your sessions.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

