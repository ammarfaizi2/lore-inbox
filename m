Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVGQTtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVGQTtD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 15:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGQTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 15:48:46 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:30354 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261367AbVGQTqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 15:46:30 -0400
Date: Sun, 17 Jul 2005 21:45:58 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com, relayfs-devel@lists.sourceforge.net
Subject: Re: [PATCH] Re: relayfs documentation sucks?
Message-ID: <20050717194558.GC27353@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
	karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
	relayfs-devel@lists.sourceforge.net
References: <17107.6290.734560.231978@tut.ibm.com> <20050716210759.GA1850@outpost.ds9a.nl> <17113.38067.551471.862551@tut.ibm.com> <20050717090137.GB5161@outpost.ds9a.nl> <17114.31916.451621.501383@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17114.31916.451621.501383@tut.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 10:43:40AM -0500, Tom Zanussi wrote:

> It is racey - in this mode, there's nothing to keep the kernel from
> writing as much as it wants before the user side has a chance to read
> any of it.  The only way this can be used safely is to make sure the
> kernel side isn't writing anything when the client is reading.  This
> would be typical of a flight-recording usage i.e. kernel writes a
> bunch of data continuously, then stops and allows the client to read
> whatever's in there.

Or by numbering entries written out, when in flight-recording mode you
wouldn't want to block the kernel.

>  > In fact, it appears this might even happen in non-overwrite mode.
> 
> It shouldn't ever be able to happen in non-overwrite mode - if it
> did, it would be a bug.  Can you be more specific as to how you see
> this happening in this mode?

Yeah - you're right. The misunderstanding is because in both cases
(overwrite and non-overwrite) data is lost, except that in one case you lose
old data, and in the other new data.

It might be a good idea to document this as well.

Btw, I've already uncovered interesting things using relayfs, but I still
don't see the case for having it merged :-)

Thanks for your answers, I think I get it all now.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
