Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTEETRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 15:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTEETRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 15:17:48 -0400
Received: from verein.lst.de ([212.34.181.86]:20232 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261241AbTEETRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 15:17:48 -0400
Date: Mon, 5 May 2003 21:30:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove unused funcion proc_mknod
Message-ID: <20030505213004.B24006@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	viro@parcelfarce.linux.theplanet.co.uk, perex@suse.cz,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030505190045.A22238@lst.de> <20030505192248.GD10374@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030505192248.GD10374@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Mon, May 05, 2003 at 08:22:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 08:22:48PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> manually.  IOW, removal of proc_mknod() won't solve anything.  The
> real question is whether we should allow device nodes on procfs.
> If we should not allow them, ALSA needs API changes.  If we should,
> it'd be better to have creation of such nodes explicit (and if ALSA
> keeps doing that, it should switch to calling proc_mknod()).

We shouldn't.  It's very bad style.  And it seems ALSA also registers a
chardev and devfs entries for that stuff.

Jaroslav, can we just drop that junk or is it still used by userland.
And if yes how long will it take to get an alsa-libs release out to
not rely on it?
