Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269776AbUJAMnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269776AbUJAMnE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 08:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269777AbUJAMnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 08:43:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269776AbUJAMms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 08:42:48 -0400
Date: Fri, 1 Oct 2004 13:42:43 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
Subject: Re: [Ext2-devel] Re: [Patch 7/10]: ext3 online resize: SMP locking for group metadata
Message-ID: <20041001124243.GA16153@parcelfarce.linux.theplanet.co.uk>
References: <200409301323.i8UDNo99004796@sisko.scot.redhat.com> <20041001101822.GA18786@elf.ucw.cz> <1096630838.2001.14.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096630838.2001.14.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:40:38PM +0100, Stephen C. Tweedie wrote:
> So I don't want to make it atomic if I can avoid it.  It's just an
> unsigned long, and I don't know of any cases where a simple read
> colliding with a write is going to give the reader a corrupt value.  As
> long as I get either the old or new value, everything should be fine
> with the read/write barriers as they are.

I think all Linux architectures guarantee atomic updates of a
register-sized naturally-aligned piece of memory.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
