Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVANPbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVANPbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVANPbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:31:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3775 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262008AbVANPba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:31:30 -0500
Date: Fri, 14 Jan 2005 16:31:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41E7A7A6.3060502@opersys.com>
Message-ID: <Pine.LNX.4.61.0501141626310.6118@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jan 2005, Karim Yaghmour wrote:

> Andi Kleen wrote:
> > When you have a timing bug and your logger starts to block randomly
> > you also won't debug anything. Fix is to make your buffers bigger.
> 
> relayfs allows you to choose which is best for you.
> 
> >From Documentation/filesystems/relayfs.txt:
> ...
> int    relay_open(channel_path, bufsize, nbufs, channel_flags,
> 		  channel_callbacks, start_reserve, end_reserve,
> 		  rchan_start_reserve, resize_min, resize_max, mode,
> 		  init_buf, init_buf_size)

You don't think that's a little overkill?
BTW it should return a pointer not an id, at every further access it needs 
to be looked up, killing the effects of any lockless mechanism.

bye, Roman
