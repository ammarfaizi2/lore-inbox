Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCLMM2>; Mon, 12 Mar 2001 07:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129800AbRCLMMI>; Mon, 12 Mar 2001 07:12:08 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:4587 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129740AbRCLMMC>; Mon, 12 Mar 2001 07:12:02 -0500
Date: Mon, 12 Mar 2001 12:12:25 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Rename all derived CONFIG variables
In-Reply-To: <20736.984380602@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0103121149540.1194-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Mar 2001, Keith Owens wrote:
> In 2.4.2-ac18 there are 130 CONFIG options that are always derived from
> other options, the user has no control over them.  It is useful for the
> kernel build process to know which variables are derived and which
> variables the user can control.

If it's useful for the (future?) kernel build process to know this,
shouldn't that config/build process derive this info itself, rather
than going by _DERIVED on the end of a CONFIG_ name?

And aren't there many CONFIG_ options (I think your "always" implies
so) which are derived in some cases (e.g. on some architectures),
specified by the user in others?  Those don't get to be called
_DERIVED though often they are derived.

And easy to imagine an option always derived in one release, sometimes
specified in the next, always derived in the next...  Yes, we can
keep on editing the CONFIG_ name in all sources affected, but I
just don't think the name should be trying to carry that info.

Hugh

