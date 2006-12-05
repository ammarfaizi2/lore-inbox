Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030816AbWLEUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816AbWLEUJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030886AbWLEUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:09:18 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34773 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030816AbWLEUJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:09:17 -0500
Message-Id: <200612052007.kB5K7ntk023359@laptop13.inf.utfsm.cl>
To: "Marty Leisner" <linux@rochester.rr.com>
cc: linux-kernel@vger.kernel.org, bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd 
In-Reply-To: Message from "Marty Leisner" <linux@rochester.rr.com> 
   of "Tue, 05 Dec 2006 12:20:30 CDT." <200612051720.kB5HKU4i001616@dell2.home> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 05 Dec 2006 17:07:49 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 05 Dec 2006 17:07:56 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marty Leisner <linux@rochester.rr.com> wrote:
> I'm working on an embedded system with the 2.6 kernel -- cpio
> initrd was a new feature I'm looking at (and very welcome).
> 
> The major advantage I see is you don't have MAKE a filesystem
> on the build host (doing cross development).  So you don't have
> to be root.

> But its "useful" to change permissions/ownership of the initrd
> files at times...

> Since a cpio is just a userspace created string of bits, I suppose
> you can apply a set of ownership/permissions to files IN the archive
> by playing with the bits...

The easy way out is to unpack the initrd, fix permissions, and repack. That
requires root, though (it creates devices).

> Does such a tool exist?  Comments?  Seems very useful in order to
> avoid being root...

I'd use sudo(1) + specially cooked commands to unpack/pack an initrd. It is
a bit more work, but gives you extra flexibility (i.e., not just futzing
around with permissions, can also add/replace/edit/rename/delete files, ...
using bog standard tools).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
