Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSJHXbN>; Tue, 8 Oct 2002 19:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261441AbSJHXay>; Tue, 8 Oct 2002 19:30:54 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:40441 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S263241AbSJHXad>; Tue, 8 Oct 2002 19:30:33 -0400
Date: Tue, 8 Oct 2002 19:36:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] silence an unnescessary raid5 debugging message
Message-ID: <20021008193612.H15858@redhat.com>
References: <20021008180350.A15858@redhat.com> <15779.27330.284336.914423@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15779.27330.284336.914423@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Oct 09, 2002 at 09:31:14AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 09:31:14AM +1000, Neil Brown wrote:
> This is there as a 'printk' deliberately.  It warns you that what you
> are doing isn't really supported and will cause a substantial
> performance hit (as all IO to the array is completely serialised
> around one of these messages).

As it stands, the syslogging from the printk does more damage to performance 
than the underlying problem.  Besides, LVM snapshots are slow, but they're 
useful for a class of problems anyways.

		-ben
