Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129961AbRBZUY5>; Mon, 26 Feb 2001 15:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBZUYy>; Mon, 26 Feb 2001 15:24:54 -0500
Received: from ns.caldera.de ([212.34.180.1]:50959 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129986AbRBZUYk>;
	Mon, 26 Feb 2001 15:24:40 -0500
Date: Mon, 26 Feb 2001 21:23:51 +0100
From: Christoph Hellwig <hch@caldera.de>
To: "Peter J. Braam" <braam@mountainviewdata.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Ronald G. Minnich" <rminnich@lanl.gov>
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
Message-ID: <20010226212351.A15963@caldera.de>
Mail-Followup-To: "Peter J. Braam" <braam@mountainviewdata.com>,
	Alexander Viro <viro@math.psu.edu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ronald G. Minnich" <rminnich@lanl.gov>
In-Reply-To: <Pine.GSO.4.21.0102242253460.24312-100000@weyl.math.psu.edu> <NEBBIIJKCMJGDLNAMBCBMEDKCEAA.braam@mountainviewdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <NEBBIIJKCMJGDLNAMBCBMEDKCEAA.braam@mountainviewdata.com>; from braam@mountainviewdata.com on Mon, Feb 26, 2001 at 08:26:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2001 at 08:26:23AM -0800, Peter J. Braam wrote:
>  - when you login, you get imounted into an environment where you have full
> priviliges (except mknod).  The "/" of your environment is not a directory
> in the Unix tree.
>  - in this environment the system file systems are available to you on a
> copy on write private basis.
>  - any files you change get out over a network file system to a server.  We
> used InterMezzo backed by a ramfs cache.
> 
> When the user logs out, everything is gone, except possibly footprints in
> swap.

These changes can be used separately, can't they?
I'd really like to use them with Al's more generic namespaces concept.
Once thing that worries is that his patch want special privilegs for
creating a new namespace and I wonder if we really want that...

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
