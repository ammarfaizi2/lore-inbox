Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292980AbSB0Vsc>; Wed, 27 Feb 2002 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292992AbSB0VsQ>; Wed, 27 Feb 2002 16:48:16 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:16645 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S292983AbSB0Vpk>;
	Wed, 27 Feb 2002 16:45:40 -0500
From: Cort Dougan <cort@fsmlabs.com>
Date: Wed, 27 Feb 2002 14:44:42 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Val Henson <val@nmt.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
        Laurent <laurent@augias.org>, linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
Message-ID: <20020227144442.Y31381@host171.fsmlabs.com>
In-Reply-To: <20020227140432.L20918@boardwalk> <E16gBps-0005wa-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gBps-0005wa-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 27, 2002 at 09:42:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's a good solution in the general case but doesn't work for
some of the proc entries that already exist.  cpuinfo, for example.
There seem to be a number of niche /proc methods already.  A cache-on-open
method would be very useful for files like cpuinfo and a number of other
files for PPC.

It sure would make accessing /proc files less whacky for user-code.

} Another approach is to do the calculation open and remember it in per
} fd private data. You can recover that and free it on release. It could
} even be a buffer holding the actual "content"
