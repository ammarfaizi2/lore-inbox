Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267695AbTAHDyZ>; Tue, 7 Jan 2003 22:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267697AbTAHDyZ>; Tue, 7 Jan 2003 22:54:25 -0500
Received: from unthought.net ([212.97.129.24]:57763 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S267695AbTAHDyY>;
	Tue, 7 Jan 2003 22:54:24 -0500
Date: Wed, 8 Jan 2003 05:03:03 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More tests [Was: Problem with read blocking for a long time on /dev/scd1]
Message-ID: <20030108040303.GE3960@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg Stark <gsstark@mit.edu>, linux-kernel@vger.kernel.org
References: <87adj0b3hj.fsf@stark.dyndns.tv> <87u1h799v5.fsf@stark.dyndns.tv> <87of7euj51.fsf_-_@stark.dyndns.tv> <20021222201345.GG30634@unthought.net> <87n0mxt8md.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87n0mxt8md.fsf@stark.dyndns.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 03:58:02AM -0500, Greg Stark wrote:
> Jakob Oestergaard <jakob@unthought.net> writes:
> 
...
> When your process is blocked, what wait channel does ps -elf list for it?
> What system call does strace -T show it executing and for how long?

On the NFS server, knfsd and kupdated will block on "wait_on_b" (WCHAN
in top).

I guess an strace on the NFS client would just show the process waiting
in some open/read/write/close code, waiting for NFS/RPC. Not much good.

The hangs last for approximately 5 seconds, sometimes around 10.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
