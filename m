Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbULVXyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbULVXyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 18:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbULVXyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 18:54:51 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:60830 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262082AbULVXyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 18:54:49 -0500
Date: Thu, 23 Dec 2004 00:54:48 +0100
From: Andi Kleen <ak@suse.de>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3, i386: fpu handling on sigreturn
Message-ID: <20041222235448.GA17720@verdi.suse.de>
References: <41C9B21F.90802@fujitsu-siemens.com.suse.lists.linux.kernel> <p73mzw5zzk2.fsf@verdi.suse.de> <41CA0813.1070707@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CA0813.1070707@fujitsu-siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 12:49:39AM +0100, Bodo Stroesser wrote:
> Andi Kleen wrote:
> >Bodo Stroesser <bstroesser@fujitsu-siemens.com> writes:
> >
> >>Now, the interrupted processes fpu no longer is cleared!
> >
> >
> >I agree it's a bug, although it's probably pretty obscure so people
> >didn't notice it.  The right fix would be to just clear_fpu again
> >in this case.  The problem has been in Linux forever.
> Wouldn't it be better to also reset used_math to 0? (As it has been,
> before the sighandler was started)

It would only be an optimization, and i doubt it's worth to optimize for 
such an obscure case. 

-Andi
