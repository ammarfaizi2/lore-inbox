Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUAaPhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 10:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUAaPhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 10:37:45 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:24030 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264903AbUAaPho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 10:37:44 -0500
Date: Sat, 31 Jan 2004 16:37:43 +0100
From: bert hubert <ahu@ds9a.nl>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131153743.GA13834@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Matthias Urlichs <smurf@smurf.noris.de>, linux-kernel@vger.kernel.org
References: <20040131104606.GA25534@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131104606.GA25534@kiste>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 11:46:06AM +0100, Matthias Urlichs wrote:

> This partial trace is from Debian's mini-dinstall, which is a
> multithreaded Python script.
> 
> What happens here is that it spawns a bunch of threads, then some of
> these fork+execve external programs which they waitpid() for.
> 
> Unfortunately, some of these waitpid() calls don't return even though 
> the waited-for process clearly has exited.

It might be that in the NPTL world only one waitpid() can run per process
simultaneously? Do you wait for all pids or for a specific one?

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
