Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWKDAud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWKDAud (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWKDAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:50:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22144 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932534AbWKDAuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:50:32 -0500
Date: Fri, 3 Nov 2006 16:46:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
In-Reply-To: <200611031902_MC3-1-D042-CA1F@compuserve.com>
Message-ID: <Pine.LNX.4.64.0611031645141.25218@g5.osdl.org>
References: <200611031902_MC3-1-D042-CA1F@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Nov 2006, Chuck Ebbert wrote:
>
> There is no real need to save eflags in switch_to().  Instead,
> we can keep a constant value in the thread_struct and always
> restore that.

I don't really see the point. The "pushfl" isn't the expensive part, and 
it gives sane and expected semantics.

The "popfl" is the expensive part, and that's the thing that can't really 
even be removed.

			Linus
