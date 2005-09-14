Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbVINBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbVINBuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 21:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbVINBuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 21:50:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31883 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932569AbVINBuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 21:50:12 -0400
Date: Wed, 14 Sep 2005 02:50:03 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sripathi Kodi <sripathik@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, patrics@interia.pl,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
Message-ID: <20050914015003.GW25261@ZenIV.linux.org.uk>
References: <4325BEF3.2070901@in.ibm.com> <20050912134954.7bbd15b2.akpm@osdl.org> <4326CFE2.6000908@in.ibm.com> <Pine.LNX.4.58.0509130744070.3351@g5.osdl.org> <20050913165102.GR25261@ZenIV.linux.org.uk> <Pine.LNX.4.58.0509131000040.3351@g5.osdl.org> <20050913171215.GS25261@ZenIV.linux.org.uk> <43274503.7090303@in.ibm.com> <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509131601400.26803@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:10:21PM -0700, Linus Torvalds wrote:
> 
> > get it from some other thread? Below is the patch I tried for this:
 
> I don't think this is wrong per se, but you shouldn't take the tasklist 
> lock normally. You're better off just doing

Could you exlain why we might want to bother with that in the first place?
In any case, why would we want to put that stuff on the common codepath
instead of specialized ->permission()?
