Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbUBUIE2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 03:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUBUIE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 03:04:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57773 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261336AbUBUIE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 03:04:27 -0500
Date: Sat, 21 Feb 2004 08:04:26 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Tridge <tridge@samba.org>,
       Jamie Lokier <jamie@shareable.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: explicit dcache <-> user-space cache coherency, sys_mark_dir_clean(), O_CLEAN
Message-ID: <20040221080426.GO31035@parcelfarce.linux.theplanet.co.uk>
References: <20040219163838.GC2308@mail.shareable.org> <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040220120417.GA4010@elte.hu> <Pine.LNX.4.58.0402200733350.1107@ppc970.osdl.org> <20040220170438.GA19722@elte.hu> <Pine.LNX.4.58.0402200911260.2533@ppc970.osdl.org> <20040220184822.GA23460@elte.hu> <20040221075853.GA828@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221075853.GA828@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 08:58:53AM +0100, Ingo Molnar wrote:
> filesystems that dont have 64-bit, monotonic timestamps will return
> -ENOSYS. This should include even XFS at the moment, because the
> timestamp is not guaranteed to be monotonic.
 
> any other problems with this concept?

If we are demanding specific filesystems, we could simply say "use
JFS in case-insensitive mode" and be done with that.  Which deals
with all problems, since fs code will guarantee uniqueness, etc.
