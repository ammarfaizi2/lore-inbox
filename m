Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFXPbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFXPbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:31:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262589AbTFXP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:29:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.5.72: follow_mount / follow_link
Date: 24 Jun 2003 08:42:56 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bd9ri0$fn2$1@cesium.transmeta.com>
References: <3EF86337.1020103@sun.com> <20030624145418.GP6754@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030624145418.GP6754@parcelfarce.linux.theplanet.co.uk>
By author:    viro@parcelfarce.linux.theplanet.co.uk
In newsgroup: linux.dev.kernel
>
> On Tue, Jun 24, 2003 at 10:41:59AM -0400, Mike Waychison wrote:
> 
> > The changes made in fs/namei.c@1.42 break this behaviour iff the dentry 
> > being follow_link'ed is a root dentry.  This is becauseo
> 
> ... mixing symlinks and mounting is ripe with very ugly races and corner
> cases.  Not allowed - symlink can't be a mountpoint or a mounted object.
>

Unfortunately, this is probably the only realistic way to ever get
working direct mounts, so please don't dismiss it out of hand.
follow_link on a directory has turned out to be a really useful way of
doing automounting.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
