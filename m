Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269669AbUHZU6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269669AbUHZU6y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269658AbUHZU45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:57 -0400
Received: from dp.samba.org ([66.70.73.150]:37560 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269644AbUHZUwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:52:20 -0400
Date: Thu, 26 Aug 2004 13:52:18 -0700
From: Jeremy Allison <jra@samba.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Diego Calleja <diegocg@teleline.es>, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826205218.GE1570@legion.cup.hp.com>
Reply-To: Jeremy Allison <jra@samba.org>
References: <Pine.LNX.4.58.0408261217140.2304@ppc970.osdl.org> <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <20040826204841.GC5733@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826204841.GC5733@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 09:48:41PM +0100, Jamie Lokier wrote:
> 
> This is why I favour storing all essential metadata (about the file's
> content) inside the file's contents, the primary stream.
> 
> We have another problem: what happens when users want to transfer data
> from Windows (with secondary streams) and MacOS (with resource forks)?

I can tell you that - right now we (Samba) has to drop all but the primary stream,
because the Linux filesystems don't have data stream support. Oh look,
we're losing user data (that's a *bad* thing :-).

Jeremy.
