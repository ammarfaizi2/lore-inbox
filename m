Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVJVRBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVJVRBp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbVJVRBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:01:44 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:13968
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750743AbVJVRBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:01:40 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ian Kent <raven@themaw.net>
Subject: Re: /etc/mtab and per-process namespaces
Date: Wed, 19 Oct 2005 22:53:42 -0500
User-Agent: KMail/1.8
Cc: Mike Waychison <mikew@google.com>, Ram <linuxram@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, leimy2k@gmail.com
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <434F13A7.8090608@google.com> <Pine.LNX.4.58.0510170846250.18878@wombat.indigo.net.au>
In-Reply-To: <Pine.LNX.4.58.0510170846250.18878@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510192253.43371.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 October 2005 19:47, Ian Kent wrote:

> > Or,  you bite the bullet and fix /proc/mounts and let distributions bind
> > mount /proc/mounts over /etc/mtab.
> >
> > Sun recognized this as a problem a long time ago and /etc/mnttab has
> > been magic for quite some time now.
>
> Don't forget to update mount as well.
>
> Ian

I'm the maintainer of the busybox mount command.  We've had /etc/mtab support 
be optional (you can configure it out) for a while now.

There was some fancy footwork trying to get umount to automatically free loop 
devices and such, but as far as I know that's all resolved in subversion and 
if we can ever get a 1.1 release out, it should all just work...

Rob
