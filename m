Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272125AbTHDSuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272126AbTHDSuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 14:50:52 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:14981 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S272125AbTHDSue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 14:50:34 -0400
From: jlnance@unity.ncsu.edu
Date: Mon, 4 Aug 2003 14:50:33 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804185033.GA19998@ncsu.edu>
References: <20030804141548.5060b9db.skraw@ithnet.com> <20030804134415.GA4454@win.tue.nl> <20030804155604.2cdb96e7.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804170506.11426617.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 05:05:06PM +0200, Stephan von Krawczynski wrote:

> tar --dereference loops on symlinks _today_, to name an example.
> All you have to do is to provide a way to find out if a directory is a
> hardlink, nothing more. And that should be easy.

Actually I think that is the crux of the problem.  If I do:

    touch a
    ln a b

then a and b are both links to the same file.  It is not like a is the
real file and b is a link to it.  The situation is indistinguishable
from:

    touch b
    ln b a

When you say that you want hardlinks to work on directories I believe
people are making the assumption that you want this to hold true for
directories as well.  The difference between hardlinking directories
and using symlinks or mount --bind is that there IS a difference between
a directory and a link to the directory.

Thanks,

Jim
