Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263809AbUDVH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUDVH6s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUDVH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:57:58 -0400
Received: from styx.suse.cz ([82.208.2.94]:1153 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263826AbUDVH5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:57:22 -0400
Date: Thu, 22 Apr 2004 09:58:01 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] New set of input patches: atkbd - use bitfields
Message-ID: <20040422075801.GA585@ucw.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210057.52989.dtor_core@ameritech.net> <20040422073113.GD340@ucw.cz> <200404220241.11546.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404220241.11546.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 02:41:11AM -0500, Dmitry Torokhov wrote:
> On Thursday 22 April 2004 02:31 am, Vojtech Pavlik wrote:
> > On Wed, Apr 21, 2004 at 12:57:51AM -0500, Dmitry Torokhov wrote:
> > > 
> > > ===================================================================
> > > 
> > > 
> > > ChangeSet@1.1909, 2004-04-20 22:29:12-05:00, dtor_core@ameritech.net
> > >   Input: remove unneeded fields in atkbd structure, convert to bitfields
> > 
> > I think this is incorrect. We cannot set the bits in bitfields
> > atomically, which we need in some cases. We probably need to add
> > volatiles to some of them, too.
> > 
> > 
> 
> I don't think we have a problem with concurrent access here... One group is set
> exclusively in atkbd_interrupt, other one is pretty mich static.

Ok, then. I'll check them one by one anyway.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
