Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbUAaVSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 16:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUAaVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 16:18:46 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:58775 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265081AbUAaVSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 16:18:45 -0500
Date: Sat, 31 Jan 2004 22:18:26 +0100
From: bert hubert <ahu@ds9a.nl>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, molnar@elte.hu, phil-list@redhat.com
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131211826.GA24791@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org, molnar@elte.hu, phil-list@redhat.com
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste> <20040131161805.GA15941@outpost.ds9a.nl> <20040131181518.GB1815@kiste> <20040131191923.GA21333@outpost.ds9a.nl> <20040131204914.GB2160@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131204914.GB2160@kiste>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:49:14PM +0100, Matthias Urlichs wrote:

> Your test program works... except that it reports, when I strace it,
> 
> [pid 10629] waitpid(10631, Process 10629 suspended
>  <unfinished ...>
> [pid 10628] <... mmap2 resumed> )       = 0x41966000
> [pid 10630] waitpid(10632, Process 10630 suspended
> <unfinished ...>
> 
> Those "Process ### suspended" messages did NOT happen with the Python
> script that exhibits the bug.

This means your situation is different from what you describe. Python may
not in fact be doing 'real' threading on your setup. I suggest you try to
make the smallest possible python program that exhibits the program and send
it to the list.

Can you also run the Python program with LD_ASSUME_KERNEL=2.4 ? And my
program too.

Thanks.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
