Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318203AbSGQDJv>; Tue, 16 Jul 2002 23:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318204AbSGQDJu>; Tue, 16 Jul 2002 23:09:50 -0400
Received: from pD952AE51.dip.t-dialin.net ([217.82.174.81]:21399 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318203AbSGQDJt>; Tue, 16 Jul 2002 23:09:49 -0400
Date: Tue, 16 Jul 2002 21:10:49 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Elladan <elladan@eskimo.com>
cc: Thunder from the hill <thunder@ngforever.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, <linux-kernel@vger.kernel.org>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <20020717030043.GA31110@eskimo.com>
Message-ID: <Pine.LNX.4.44.0207162108480.3452-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Jul 2002, Elladan wrote:
> > Thread 2 shouldn't be able to reuse a currently open fd. This application 
> > design is seriously broken.

Okay, again. It's about doing a second close() in case the first one fails 
with EAGAIN. If we have to do it again, the filehandle is not closed, and 
if the filehandle is not closed, the kernel knows that, and if the kernel 
knows that the filehandle is still open, it won't get reassigned. Problem 
gone.

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

