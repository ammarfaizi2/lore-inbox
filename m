Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWJFEeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWJFEeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWJFEeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:34:15 -0400
Received: from gw.goop.org ([64.81.55.164]:14516 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750817AbWJFEeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:34:14 -0400
Message-ID: <4525DCC5.40101@goop.org>
Date: Thu, 05 Oct 2006 21:34:13 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Really good idea to allow mmap(0, FIXED)?
References: <200610052059.11714.mb@bu3sch.de> <eg4624$be$1@taverner.cs.berkeley.edu>
In-Reply-To: <eg4624$be$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> Is this right?  Have I correctly understood the issue?

More or less, though a simpler example would be something like:

    if (thing->uid == 0)
        do_magic();

and if "thing" happens to be in userspace (NULL or otherwise) then the 
user can control this test.  So the answer is that the kernel shouldn't 
be looking at uninitialized pointers.

    J
