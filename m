Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTCOIdl>; Sat, 15 Mar 2003 03:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbTCOIdk>; Sat, 15 Mar 2003 03:33:40 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:63362 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261364AbTCOIdj>; Sat, 15 Mar 2003 03:33:39 -0500
Date: Sat, 15 Mar 2003 08:41:57 -0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Mitch Adair <mitch@theneteffect.com>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update filesystems config. menu
Message-ID: <20030315094151.GA16373@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Mitch Adair <mitch@theneteffect.com>,
	"Randy.Dunlap" <randy.dunlap@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200303150819.h2F8JfW15921@mako.theneteffect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303150819.h2F8JfW15921@mako.theneteffect.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 02:19:40AM -0600, Mitch Adair wrote:

 > I seem to recall if you say Y to ext2 and Y to ext3 and your root is on ext3
 > then it's likely to be mounted as ext2 unless you set rootfstype=...
 > The ext3 help comment also warns you should set it to Y, so people with
 > root ext3 are likely to get a surprise if they follow both help.  Would it
 > be better to say something like "if your root partition is extX you almost
 > certainly want to say Y here"?  Or warn about the rootfstype issue maybe?

(03:40:50:davej@tetrachloride:davej)$ mount
/dev/hda5 on / type ext3 (rw,errors=remount-ro)

(08:40:13:davej@tetrachloride:davej)$ cat /proc/filesystems | grep ext
	ext3
	ext2

Note the ordering, ext3 gets tried before ext2.

		Dave

