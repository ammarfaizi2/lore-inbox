Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVDJN4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDJN4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDJN4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:56:34 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:19497 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261220AbVDJN4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:56:33 -0400
Date: Sun, 10 Apr 2005 09:51:37 -0400
From: David Roundy <droundy@abridgegame.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-ID: <20050410135136.GI809@abridgegame.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <87d5t73pnf.fsf@osv.topcon.com> <20050407103018.GA22906@merlin.emma.line.org> <20050409161748.GM14943@abridgegame.org> <1w4vjipg6p8rz$.13acy97i9ayhl.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1w4vjipg6p8rz$.13acy97i9ayhl.dlg@40tude.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 11:24:07AM +0200, Giuseppe Bilotta wrote:
> On Sat, 9 Apr 2005 12:17:58 -0400, David Roundy wrote:
> 
> > I've recently made some improvements recently which will reduce the
> > memory use
> 
> Does this include check for redundancy? ;)

Yeah, the only catch is that if the redundancy checks fail, we now may
leave the repository in an inconsistent, but repairable, state.  (Only a
cache of the pristine tree is affected.)  The recent improvements mostly
came by increasing the laziness of a few operations, which meant we don't
need to store the entire parsed tree (or parsed patch) in memory for
certain operations.
-- 
David Roundy
http://www.darcs.net
