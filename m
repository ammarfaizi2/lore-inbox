Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbUEAOq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUEAOq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 10:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUEAOq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 10:46:28 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:43710 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262019AbUEAOqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 10:46:25 -0400
Date: Sat, 1 May 2004 16:46:24 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Alex Lyashkov <shadow@psoft.net>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
Message-ID: <20040501144624.GA26495@MAIL.13thfloor.at>
Mail-Followup-To: Alex Lyashkov <shadow@psoft.net>,
	Jeff Dike <jdike@addtoit.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040430174117.A13372@infradead.org> <Pine.LNX.4.44.0404301502550.6976-100000@chimarrao.boston.redhat.com> <4092AD60.1030809@watson.ibm.com> <200404302217.i3UMHdml004610@ccure.user-mode-linux.org> <20040430234332.GA10569@MAIL.13thfloor.at> <1083391814.8172.8.camel@berloga.shadowland>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083391814.8172.8.camel@berloga.shadowland>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 09:10:15AM +0300, Alex Lyashkov wrote:
> ? ???, 01.05.2004, ? 02:43, Herbert Poetzl ?????:
> > On Fri, Apr 30, 2004 at 06:17:39PM -0400, Jeff Dike wrote:
> > > nagar@watson.ibm.com said:
> > > > Jeff, do you have any numbers for UML overhead in 2.6 ? 
> > > 
> > > It obviously depends on the workload, but for "normal" things, like kernel
> > > builds and web serving, it's generally in the 20-30% range.  That can be 
> > > reduced, since I haven't spent too much time on tuning.  I'm aiming for the
> > > teens, and I don't think that'll be too hard.
> > 
> > hmm, just wanted to mention that linux-vserver has
> > around 0% overhead and often allows to improve 
> > performance due to resource sharing ... 
> > 
> Herber please not say vserver have - 0 overhead. 
> it generally wrong.

well, I said around 0%, but it's actually a long time
since we measured that, and I'll schedule some
tests next week, to see if the overhead is still
not measureable with 'normal' userspace testing

> But overhead less than UML is right.

that is for sure, and it benefits from not having
everything twice, like inode cache, dentry cache,
page cache ...

best,
Herbert

> > basically it's a soft partitioning concept based on 
> > 'Security Contexts' which allow to create many 
> > independant Virtual Private Servers (VPS), which
> > act simultaneously on one box at full speed, sharing
> > the available hardware resources.
> > 
> > see http://linux-vserver.org for details ...
> > 
> > best,
> > Herbert
> > 
> > PS: UML and Linux-VServer play together nicely ...
> > 
> > > 
> > > 				Jeff
> > > 
> > > -------------------------------------------------------
> > > This SF.Net email is sponsored by: Oracle 10g
> > > Get certified on the hottest thing ever to hit the market... Oracle 10g. 
> > > Take an Oracle 10g class now, and we'll give you the exam FREE. 
> > > http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> > > _______________________________________________
> > > ckrm-tech mailing list
> > > https://lists.sourceforge.net/lists/listinfo/ckrm-tech
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> Alex Lyashkov <shadow@psoft.net>
> PSoft
