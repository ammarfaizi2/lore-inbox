Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266075AbUHRMTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUHRMTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUHRMTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:19:54 -0400
Received: from mail.gmx.de ([213.165.64.20]:53674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266075AbUHRMTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:19:53 -0400
X-Authenticated: #1725425
Date: Wed, 18 Aug 2004 14:20:46 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: andreas.messer@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
Message-Id: <20040818142046.36499779.Ballarin.Marc@gmx.de>
In-Reply-To: <41234500.5080500@bio.ifi.lmu.de>
References: <411FD919.9030702@comcast.net>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de>
	<200408171311.06222.satura@proton>
	<20040817155927.GA19546@proton-satura-home>
	<41234500.5080500@bio.ifi.lmu.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 14:01:04 +0200
Frank Steiner <fsteiner-mail@bio.ifi.lmu.de> wrote:

> So it seems that the new commands that I added are just ignored and have
> no effect when running growisofs as user.
> 
> How can that be? Am I missing sth? Is the order in which the commands
> are added via safe_for_read important?
> 

growisofs and dvd+r-format open the device read-only, even though they try
to do writes.

Two choices:
1) declare all needed commands as safe for read (you might as well disable
filtering completely...)

2) replace O_RDONLY in dvd+r-tools sources with O_RDWR and recompile
(that's what I did).

Marc
