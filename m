Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264661AbSKDMfS>; Mon, 4 Nov 2002 07:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSKDMfS>; Mon, 4 Nov 2002 07:35:18 -0500
Received: from p508B7C3B.dip.t-dialin.net ([80.139.124.59]:32946 "EHLO
	p508B7C3B.dip.t-dialin.net") by vger.kernel.org with ESMTP
	id <S264661AbSKDMfR>; Mon, 4 Nov 2002 07:35:17 -0500
Date: Mon, 4 Nov 2002 13:41:48 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: linux/bug.h and asm/bug.h
Message-ID: <20021104134148.B19377@bacchus.dhis.org>
References: <20021104022350.DB97A2C0C0@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021104022350.DB97A2C0C0@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Nov 04, 2002 at 01:22:45PM +1100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:22:45PM +1100, Rusty Russell wrote:

> As the number of bug-related macros grows, this makes sense.
> 
> 1) Introduce linux/bug.h and #include it from linux/kernel.h so noone
>    breaks.
> 2) Move BUG() macro from asm*/page.h to asm*/bug.h, and #include it.

Great, people were talking about the mess caused by this just last night.
Just one request, move the BUG_ON definition into <asm/bug.h> also.  This
permits the use of conditional trap instructions for those architecture
that have them.

  Ralf
