Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVAPFjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVAPFjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 00:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVAPFjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 00:39:39 -0500
Received: from almesberger.net ([63.105.73.238]:55559 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262433AbVAPFjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 00:39:35 -0500
Date: Sun, 16 Jan 2005 02:38:30 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, mst@mellanox.co.il,
       tiwai@suse.de, mingo@elte.hu, rlrevell@joe-job.com,
       linux-kernel@vger.kernel.org, pavel@suse.cz, gordon.jin@intel.com,
       VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] fix: macros to detect existance of unlocked_ioctl and compat_ioctl
Message-ID: <20050116023830.A22646@almesberger.net>
References: <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050112203606.GA23307@mellanox.co.il> <20050112212954.GA13558@kroah.com> <20050112214326.GB14703@wotan.suse.de> <20050112225230.GA14590@kroah.com> <20050112151049.7473db7d.akpm@osdl.org> <20050112231630.GB15085@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112231630.GB15085@kroah.com>; from greg@kroah.com on Wed, Jan 12, 2005 at 03:16:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc:s trimmed a little ]

Greg KH wrote:
> Sorry, the "policy" I was referring to was the "out-of-the-tree drivers
> are on their own" statement.  Not the use of the HAVE macros.

Not all users of kernel code are in- or out-of-tree drivers and the
like. E.g. tcsim (from tcng.sf.net) grabs substantial portions of
the traffic control and netlink code and merges them with user
space. It also tries to be compatible with most 2.4 kernels.

For feature tests, I use basically anything that doesn't run away
quickly enough. And I'm sure you want none of *that* kind of code 
anywhere near mainline ;-)

Not that I currently have more troubles with it than usually. I
just want to point out that there are other, strange but legitimate
(at least in the "all shall eventually be GPL" sense) users of the
kernel, who don't mind a friendly environment.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
