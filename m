Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFNT0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFNT0c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 15:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUFNT00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 15:26:26 -0400
Received: from salzburg.nitnet.com.br ([200.157.204.105]:10371 "EHLO
	nat.cesarb.net") by vger.kernel.org with ESMTP id S263815AbUFNT0Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 15:26:25 -0400
Date: Mon, 14 Jun 2004 16:25:24 -0300
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040614192524.GB1961@flower.home.cesarb.net>
References: <20040612011129.GD1967@flower.home.cesarb.net> <20040614095529.GA11563@infradead.org> <20040614134652.GA1961@flower.home.cesarb.net> <20040614140356.GA21349@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614140356.GA21349@infradead.org>
User-Agent: Mutt/1.5.6+20040523i
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 03:03:56PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 14, 2004 at 10:46:52AM -0300, Cesar Eduardo Barros wrote:
> > I don't see why preserving the mtime and ctime would be necessary, since
> > to move a file away you either don't touch it (using rename) or only
> > read and unlink it (to write to a tape or other filesystem, and you can
> > save the atime and mtime while doing it). So O_NOATIME is enough for
> > both behaviours.
> 
> Maybe some day the file needs to come back from the tape ;-)  Or rather
> in the HSM scenario a part of the file.

When it comes back, it can be written to a temporary file, have its
atime/mtime set with utimes, and atomically renamed to the right place.

If you want to play with parts of files, you would need an atime for
each block of the file ;-)

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
