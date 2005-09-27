Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVI0UjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVI0UjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVI0UjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:39:21 -0400
Received: from nevyn.them.org ([66.93.172.17]:41088 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S965047AbVI0UjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:39:20 -0400
Date: Tue, 27 Sep 2005 16:39:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] New SA_NOPRNOTIF sigaction flag
Message-ID: <20050927203919.GA18262@nevyn.them.org>
Mail-Followup-To: "Davda, Bhavesh P (Bhavesh)" <bhavesh@avaya.com>,
	linux-kernel@vger.kernel.org
References: <21FFE0795C0F654FAD783094A9AE1DFC086EFBEB@cof110avexu4.global.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21FFE0795C0F654FAD783094A9AE1DFC086EFBEB@cof110avexu4.global.avaya.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 10:24:23AM -0600, Davda, Bhavesh P (Bhavesh) wrote:
> About the priority inversion and running the debugger at higher priority
> then the debuggee, that's a moot point. You're still doing too many
> pointless context switches to the debugger only to do nothing and switch
> back to the debuggee.

Depending on your debugger, they may not be pointless.

> Besides, putting this responsibility (ignore SIGCHLDs for signal X from
> Task Y) in the debugger requires the debugger to have information about
> the debuggee, like Task Y is special for handling signal X, and I'm
> going to ptrace() ignore SIGCHLD's from Task Y.
> 
> See where I'm going with this?

Hint: your debugger already needs to know this.  GDB already does.  It
has a list of signals not to bother stopping or displaying to the user.
SIGCHLD is on it by default.  If not, you'd see the debugger prompt
after each one of these context switches.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
