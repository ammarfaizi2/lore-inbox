Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSAXKaL>; Thu, 24 Jan 2002 05:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286942AbSAXKaA>; Thu, 24 Jan 2002 05:30:00 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:44044 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286959AbSAXK3q>; Thu, 24 Jan 2002 05:29:46 -0500
Date: Thu, 24 Jan 2002 13:29:44 +0300
From: Oleg Drokin <green@namesys.com>
To: Berjoza Roman <b_rom_s@4enet.by>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs+updatedb=oops
Message-ID: <20020124132944.A20375@namesys.com>
In-Reply-To: <20020123161944Z289790-13996+10616@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020123161944Z289790-13996+10616@vger.kernel.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 23, 2002 at 06:23:12PM +0200, Berjoza Roman wrote:
> Jan 23 12:56:40 ns1 kernel: EIP:    0010:[d_lookup+92/244]    Not tainted
> Jan 23 12:56:40 ns1 kernel: Process kdeinit (pid: 3279, stackpage=c2fbf000)
> Jan 23 12:56:40 ns1 kernel: Call Trace: [cached_lookup+16/84] 
> [link_path_walk+1184/1752] [getname+93/156] [path_walk+26/28] 
> [__user_walk+53/80]
Hm. But there is no reiserfs code in the calltrace.
What I can say is that in d_lookup() this code falls:
                tmp = tmp->next;
because tmp is NULL. (which means the our list is broken, right?)
I do not know how things went into this state, though.

Bye,
    Oleg
