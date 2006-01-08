Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWAHD4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWAHD4f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 22:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbWAHD4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 22:56:35 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:43973 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1752595AbWAHD4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 22:56:34 -0500
Date: Sat, 7 Jan 2006 19:56:22 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-ID: <20060108035622.GP27284@gaz.sfgoth.com>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org> <20060107190531.GB8990@kurtwerks.com> <1136663088.2936.36.camel@laptopd505.fenrus.org> <20060108031605.GB26614@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108031605.GB26614@kurtwerks.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Sat, 07 Jan 2006 19:56:23 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
>    text	   data	    bss	    dec	    hex	filename
> 2577982	 462352	 479920	3520254	 35b6fe	vmlinux.344.NO_OPT
> 2620255	 462336	 479984	3562575	 365c4f	vmlinux.442.NO_OPT
> 2326785	 462352	 479920	3269057	 31e1c1	vmlinux.344.OPT
> 2227294	 502680	 479984	3209958	 30fae6	vmlinux.442.OPT

And idea what's up with the .data size there?  The first three are almost
exactly the same (as you'd expect) and then the last one jumps up by 40K.
Is there something normally in a different section that goes into normal
.data only in that congiguration?  Might be worth looking at with:
	objdump -h vmlinux | egrep -v 'CONTENTS|ALLOC'

-Mitch
