Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUAaQKz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 11:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAaQKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 11:10:54 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:44426 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S264916AbUAaQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 11:10:53 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 16:51:55 +0100
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131155155.GA1504@kiste>
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131153743.GA13834@outpost.ds9a.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

bert hubert:
> It might be that in the NPTL world only one waitpid() can run per process
> simultaneously?

Good call ...

> Do you wait for all pids or for a specific one?
> 
... looking at the strace output, I see that thre are four different
threads calling fork+child-exec/parent-waitpid() in parallel. The last
one actually succeeds, so you might be right with this analysis.

*Sigh* No matter how many people work at that code in the kernel, it's
_still_ fragile.  :-/

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
