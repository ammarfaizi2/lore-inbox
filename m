Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWHAQ5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWHAQ5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHAQ5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:57:54 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:15884 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S1751236AbWHAQ5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:57:53 -0400
Subject: Re: metadata plugins (was Re: the " 'official' point of view"
	expressed by kernelnewbies.org regarding reiser4 inclusion)
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: =?iso-8859-2?Q?=A3ukasz?= Mierzwa <prymitive@pcserwis.hopto.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
In-Reply-To: <op.tdl2s2fpd4os1z@localhost>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
	 <44CA31D2.70203@slaphack.com>
	 <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
	 <op.tdl2s2fpd4os1z@localhost>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Aug 2006 20:43:33 +0400
Message-Id: <1154450613.10043.136.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, 2006-08-01 at 17:32 +0200, Łukasz Mierzwa wrote:
> Dnia Fri, 28 Jul 2006 18:33:56 +0200, Linus Torvalds <torvalds@osdl.org>  
> napisał:
> 
> > In other words, if a filesystem wants to do something fancy, it needs to
> > do so WITH THE VFS LAYER, not as some plugin architecture of its own. We
> > already have exactly the plugin interface we need, and it literally _is_
> > the VFS interfaces - you can plug in your own filesystems with
> > "register_filesystem()", which in turn indirectly allows you to plug in
> > your per-file and per-directory operations for things like lookup etc.

> What fancy (beside cryptocompress) does reiser4 do now?

it is supposed to provide an ability to easy modify filesystem behaviour
in various aspects without breaking compatibility.

> Can someone point me to a list of things that are required by kernel  
> mainteiners to merge reiser4 into vanilla?

list of features reiser4 does not have now:
O_DIRECT support - we are working on it now
various block size support
quota support
xattrs and acls

list of warnings about reiser4 code:
I think that last big list of useful comments (from Christoph Hellwig
<hch@infradead.org>) is addressed. Well, except for one minor (I
believe) place in file release.

Currently, Andrew is trying to find some time to review reiser4 code.

> I feel like I'm getting lost with current reiser4 status and things that  
> are need to be done.
> 
> Łukasz Mierzwa
> 

