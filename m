Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTKMApu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTKMApu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:45:50 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:42638
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S261837AbTKMAps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:45:48 -0500
Date: Wed, 12 Nov 2003 19:45:09 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031113004509.GK22850@michonline.com>
Mail-Followup-To: Andrew Walrond <andrew@walrond.org>,
	linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311111438.47868.andrew@walrond.org> <bore48$ubl$1@cesium.transmeta.com> <200311112021.34631.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311112021.34631.andrew@walrond.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 08:21:34PM +0000, Andrew Walrond wrote:
> Seriously though; There isn't another way that I can see for mirroring cvs 
> repos coherently, unless cvsup does something clever? Anyone know?

cvsup does something clever.

For non-CVS repositories, it uses the "rsync" algorithm.

For CVS repositories, it will do per-change updates.

I'm not sure what it does if a change disappears from the source
(haven't tried that yet), but I do know that if you are careful enough
to avoid creating conflicting revision numbers in the mirror, you can
*commit* to it as well.

I'm using cvsup for mirroring a CVS repository at work, and it's worked
very well (and is remarkably low load).

I believe the "mirror consistency" problem isn't solved by this
unfortunately, but considering that there are mirrors not using rsync, I
have a feeling that it's not truly solvable, entirely.

I think I can provide an example set of configuration files for cvsup
now that I've configured it 3 times, if anyone is interested.

-- 

Ryan Anderson
  sometimes Pug Majere
