Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbUAaQSI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 11:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUAaQSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 11:18:08 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:60895 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264925AbUAaQSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 11:18:06 -0500
Date: Sat, 31 Jan 2004 17:18:05 +0100
From: bert hubert <ahu@ds9a.nl>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131161805.GA15941@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131155155.GA1504@kiste>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 04:51:55PM +0100, Matthias Urlichs wrote:

> > Do you wait for all pids or for a specific one?
> > 
> ... looking at the strace output, I see that thre are four different
> threads calling fork+child-exec/parent-waitpid() in parallel. The last
> one actually succeeds, so you might be right with this analysis.
> 
> *Sigh* No matter how many people work at that code in the kernel, it's
> _still_ fragile.  :-/

If they do not wait for a specific pid, the kernel is right. The kernel has
no way of knowing which process a specific waitpid is waiting for otherwise!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
