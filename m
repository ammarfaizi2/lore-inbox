Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264068AbUDNMKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUDNMKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:10:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33989 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264068AbUDNMK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:10:29 -0400
Date: Wed, 14 Apr 2004 13:10:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: raven@themaw.net
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] umount after bad chdir
Message-ID: <20040414121026.GD31500@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0404141241450.29568-100000@localhost.localdomain> <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404142009500.1537@donald.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 08:12:33PM +0800, raven@themaw.net wrote:
> On Wed, 14 Apr 2004, Hugh Dickins wrote:
> 
> > After chdir (or chroot) to non-existent directory on 2.6.5-mm5, you
> > can no longer unmount filesystem holding working directory (or root).
> > 
> 
> Of course.
> 
> Excellent. Thanks very much.

Mind you, chdir() patch in -mm is broken in a lot of other ways - e.g.
it assumes that another thread sharing ->fs with us won't call chdir()
in the wrong moment...
