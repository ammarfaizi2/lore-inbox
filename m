Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVACTSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVACTSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVACTRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:17:07 -0500
Received: from relay.axxeo.de ([213.239.199.237]:21431 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261621AbVACTOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:14:31 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Date: Mon, 3 Jan 2005 20:14:20 +0100
User-Agent: KMail/1.6.2
Cc: Frank van Maarseveen <frankvm@frankvm.com>, Adrian Bunk <bunk@stusta.de>,
       Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>,
       luto@myrealbox.com, aebr@win.tue.nl
References: <20050102193724.GA18136@elf.ucw.cz> <20050102210536.GF4183@stusta.de> <20050103093545.GA8524@janus>
In-Reply-To: <20050103093545.GA8524@janus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501032014.20046.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen schrieb:
> On Sun, Jan 02, 2005 at 10:05:36PM +0100, Adrian Bunk wrote:
> > On Sun, Jan 02, 2005 at 09:56:50PM +0100, Pavel Machek wrote:
> > > Okay, so the right solution is probably something more like
> > >
> > > while umount /mnt; do
> > >  fuser -km -TERM /mnt
> > >  sleep 1
> > >  fuser -km /mnt
> > > done
> There's a much more interesting race: another process succesfully umounting
> the thing while this one's asleep.

For those who don't know what happens: fuser -km /mnt will act like
fuser -km / in that race and kill all processes.

BTDT :-(

