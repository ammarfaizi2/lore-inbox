Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317706AbSGPBxW>; Mon, 15 Jul 2002 21:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317731AbSGPBxV>; Mon, 15 Jul 2002 21:53:21 -0400
Received: from moutvdomng1.kundenserver.de ([195.20.224.131]:45249 "EHLO
	moutvdomng1.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317706AbSGPBxV>; Mon, 15 Jul 2002 21:53:21 -0400
Date: Mon, 15 Jul 2002 19:56:08 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Patrick J. LoPresti" <patl@curl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
In-Reply-To: <s5g8z4cphvd.fsf@egghead.curl.com>
Message-ID: <Pine.LNX.4.44.0207151952210.3452-100000@hawkeye.luckynet.adm>
X-Location: Canberra; Australia
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15 Jul 2002, Patrick J. LoPresti wrote:
> Doing that instead of fsync'ing the
> file adds at most two system calls (to open and close the directory),

Keep the directory fd open all the time, and flush it when needed. This 
gets rid of the open(dir, dd); fsync(dd); close(dd);, you just have:
open(dir, dd); once, then fsync(dd); fsync(dd); ... and then one close(dd);

Not too much of an overhead, is it?

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

