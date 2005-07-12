Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVGLD4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVGLD4h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 23:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVGLD4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 23:56:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44992 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262322AbVGLD4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 23:56:36 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.16181.300398.8599@tut.ibm.com>
Date: Mon, 11 Jul 2005 22:55:33 -0500
To: Greg KH <greg@kroah.com>
Cc: Karim Yaghmour <karim@opersys.com>, Tom Zanussi <zanussi@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <20050712032424.GA1742@kroah.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	<20050712030555.GA1487@kroah.com>
	<42D3331F.8020705@opersys.com>
	<20050712032424.GA1742@kroah.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:
 > On Mon, Jul 11, 2005 at 11:03:59PM -0400, Karim Yaghmour wrote:
 > > 
 > > Greg KH wrote:
 > > > What ever happened to exporting the relayfs file ops, and just using
 > > > debugfs as your controlling fs instead?  As all of the possible users
 > > > fall under the "debug" type of kernel feature, it makes more sense to
 > > > confine users to that fs, right?
 > > 
 > > Actually, like we discussed the last time this surfaced, there are far
 > > more users for relayfs than just debugging.
 > 
 > Based on the proposed users of this fs, I don't see any.  What ones are
 > you saying are not "debug" type operations?  And yes, I consider LTT a
 > "debug" type operation :)
 > 
 > The best part of this, is it gives distros and users a consistant place
 > to mount the fs, and to know where this kind of thing shows up in the fs
 > namespace.

Makes sense, and I don't see a problem with getting rid of the fs part
of relayfs and letting debugfs take over that role, if debugfs were
there for all potential users.  It doesn't sound like it would satisfy
users like LTT and systemtap though, who expect to be available at all
times even on production systems, which wouldn't be the case unless
the distros always shipped with debugfs enabled.

 > 
 > > What we settled on was having relayfs export its file ops so that
 > > indeed debugfs users could use it to log things in conjunction with
 > > debugfs.
 > 
 > Last I looked, this was not possible.  Has this changed in the latest
 > version?

The file operations are all exported, but I haven't actually tried to
use relayfs files in debugfs.  Is there something more needed?

Tom


