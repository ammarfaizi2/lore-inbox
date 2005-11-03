Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVKCBvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVKCBvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVKCBvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:51:14 -0500
Received: from ozlabs.org ([203.10.76.45]:12735 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030264AbVKCBvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:51:13 -0500
Subject: Re: Percpu data in a vsyscall page
From: Rusty Russell <rusty@rustcorp.com.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051102105405.GA5320@ucw.cz>
References: <20051102105405.GA5320@ucw.cz>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 12:51:11 +1100
Message-Id: <1130982671.8734.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 11:54 +0100, Vojtech Pavlik wrote:
> Hi!
> 
> I'm working on a RDTSCP support on x86-64, and for that, I'll need
> per-cpu time offset table in a vsyscall page. I saw the percpu.h header,
> and thought - "Hey, I could use that!", but I think I really can't.
> 
> The data need to be in a vsyscall page, which is mapped to userspace via
> linker magic, and the percpu stuff uses a different mapping.

Yes.  The percpu stuff uses a single add to find the local value of a
variable.  This per-cpu offset can be kept in a register (I think
Sparc64 already does this) making it v. fast.

You're going to have to stick with an array I think.

Sorry,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

