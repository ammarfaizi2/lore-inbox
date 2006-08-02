Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWHBSpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWHBSpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHBSp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:45:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62368 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932142AbWHBSpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:45:25 -0400
Message-Id: <200608021845.k72Ij7us009749@laptop13.inf.utfsm.cl>
To: "Vladimir V. Saveliev" <vs@namesys.com>
cc: =?iso-8859-2?Q?=A3ukasz?= Mierzwa <prymitive@pcserwis.hopto.org>,
       LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion) 
In-Reply-To: Message from "Vladimir V. Saveliev" <vs@namesys.com> 
   of "Tue, 01 Aug 2006 20:43:33 +0400." <1154450613.10043.136.camel@tribesman.namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Wed, 02 Aug 2006 14:45:07 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 02 Aug 2006 14:45:08 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev <vs@namesys.com> wrote:
> On Tue, 2006-08-01 at 17:32 +0200, Łukasz Mierzwa wrote:
> > Dnia Fri, 28 Jul 2006 18:33:56 +0200, Linus Torvalds <torvalds@osdl.org>  
> > napisał:
> > > In other words, if a filesystem wants to do something fancy, it needs to
> > > do so WITH THE VFS LAYER, not as some plugin architecture of its own. We
> > > already have exactly the plugin interface we need, and it literally _is_
> > > the VFS interfaces - you can plug in your own filesystems with
> > > "register_filesystem()", which in turn indirectly allows you to plug in
> > > your per-file and per-directory operations for things like lookup etc.

> > What fancy (beside cryptocompress) does reiser4 do now?
> 
> it is supposed to provide an ability to easy modify filesystem behaviour
> in various aspects without breaking compatibility.

If it just modifies /behaviour/ it can't really do much. And what can be
done here is more the job of the scheduler, not of the filesystem. Keep your
hands off it!

If it somehow modifies /on disk format/, it (by *definition*) isn't
compatible. Ditto.

> > Can someone point me to a list of things that are required by kernel  
> > mainteiners to merge reiser4 into vanilla?
> 
> list of features reiser4 does not have now:
> O_DIRECT support - we are working on it now
> various block size support

Is this required?

> quota support
> xattrs and acls

Without those, it is next to useless anyway.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
