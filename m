Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269358AbUJRCWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbUJRCWI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 22:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269353AbUJRCWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 22:22:08 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:2548 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S269358AbUJRCWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 22:22:01 -0400
Subject: Re: [RFC][PATCH] inotify 0.14
From: John McCutchan <ttb@tentacle.dhs.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Robert Love <rml@novell.com>, v13@priest.com, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
In-Reply-To: <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
References: <1097808272.4009.0.camel@vertex>
	 <200410180246.27654.v13@priest.com> <1098057129.5497.107.camel@localhost>
	 <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098066043.16758.4.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 22:20:43 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.1.0, Antispam-Data: 2004.10.17.0
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 21:28, Stephen Rothwell wrote:
> On Sun, 17 Oct 2004 19:52:09 -0400 Robert Love <rml@novell.com> wrote:
> >
> > It should make dnotify a configuration option, controlled via
> > CONFIG_DNOTIFY.
> 
> But you have removed the sysctl that allows enabling and disabling of
> dnotify at run time.  And you create setattr_mask_dnotify for which I can
> find no caller.  And make gratuitous changes to the current dnotify code.
> (I point this last out as it just increases the size of the patch for no
> purpose.)

There may be bugs with how dnotify was made optional. I will accept a
patch that fixes this :)

It is debatable whether or not the inotify patch should carry this
dnotify config patch as well. I don't see it being that large of a
burden on maintaining or using the patch that includes the dnotify
config changes. 

John
