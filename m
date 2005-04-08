Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVDHIX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVDHIX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVDHITi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:19:38 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:21125 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262758AbVDHIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 04:16:54 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Alex Zarochentsev <zam@namesys.com>
Subject: Re: [patch 1/1] reiserfs: make resize option auto-get new device size
Date: Fri, 8 Apr 2005 10:23:07 +0200
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, mtk-manpages@gmx.net
References: <20050408045553.278CA11B7FE@zion> <20050408081047.GX6211@backtop.namesys.com>
In-Reply-To: <20050408081047.GX6211@backtop.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081023.09343.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 April 2005 10:10, Alex Zarochentsev wrote:
> Hi,
>
> On Fri, Apr 08, 2005 at 06:55:50AM +0200, blaisorblade@yahoo.it wrote:
> > Cc: <reiserfs-dev@namesys.com>, <reiserfs-list@namesys.com>,
> > <mtk-manpages@gmx.net>
> >
> > It's trivial for the resize option to auto-get the underlying device
> > size, while it's harder for the user. I've copied the code from jfs.
> >
> > Since of the different reiserfs option parser (which does not use the
> > superior match_token used by almost every other filesystem), I've had to
> > use the "resize=auto" and not "resize" option to specify this behaviour.
> > Changing the option parser to the kernel one wouldn't be bad but I've no
> > time to do this cleanup in this moment.
>
> do people really need it?
Note we are speaking of 2 lines of code. And there's no point in omitting 
this.
> user-level utility reisize_reiserfs, being called w/o size argument,
> calculates the device size and uses resize mount option with correct value.
Yes, I know this. But the old versions (the one shipped on Mdk) didn't work 
for online resizing (this was verified by me with lots of warnings and a Oops 
on reiserfs code); in fact, this ability is so new that is not even 
documented in manpages.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

