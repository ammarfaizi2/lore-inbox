Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318200AbSGQCx6>; Tue, 16 Jul 2002 22:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318201AbSGQCx5>; Tue, 16 Jul 2002 22:53:57 -0400
Received: from pD952AE51.dip.t-dialin.net ([217.82.174.81]:12951 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318200AbSGQCx4>; Tue, 16 Jul 2002 22:53:56 -0400
Date: Tue, 16 Jul 2002 20:54:54 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Elladan <elladan@eskimo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Zack Weinberg <zack@codesourcery.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <20020717022252.GA30570@eskimo.com>
Message-ID: <Pine.LNX.4.44.0207162054050.3452-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Elladan wrote:
> Two threads share the file descriptor table.  
> 
>   1. Thread 1 performs close() on a file descriptor.  close fails.
>   2. Thread 2 performs open().
> * 3. Thread 1 performs close() again, just to make sure.

Thread 2 shouldn't be able to reuse a currently open fd. This application 
design is seriously broken.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

