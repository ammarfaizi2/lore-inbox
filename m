Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319735AbSIMR4B>; Fri, 13 Sep 2002 13:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319739AbSIMR4B>; Fri, 13 Sep 2002 13:56:01 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24595 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S319735AbSIMR4A>;
	Fri, 13 Sep 2002 13:56:00 -0400
Date: Fri, 13 Sep 2002 20:00:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Bray <abuse@madhouse.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
Message-ID: <20020913200051.A1758@mars.ravnborg.org>
Mail-Followup-To: Andrew Bray <abuse@madhouse.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org> <20020910230656.D18386@mars.ravnborg.org> <9500000.1031706478@aslan.btc.adaptec.com> <20020911071219.A1352@mars.ravnborg.org> <slrnao427d.si3.abuse@madhouse.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <slrnao427d.si3.abuse@madhouse.demon.co.uk>; from abuse@madhouse.demon.co.uk on Fri, Sep 13, 2002 at 03:49:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 03:49:01PM +0000, Andrew Bray wrote:
> Just a thought: should 'make clean' and/or 'make mrproper' rename the
> _shipped files back to their origilal names?
What could be done is to delete the files generated from _shipped.
Hereby they would be generated from their _shipped variants during next
the next build. Please note that they are not renamed, but copied.
But I wanted to keep current functionality and later extend as
made sense. A stepwise approach.

I also had in mind only deleting .o files generated during the build,
allowing us to get rid of the find ... in make clean.
make mrproper would need it to remove stale .o files, and the like.

Another item that popped up while doing this was a new definition of
mrproper and clean.
They are clearly mixed, and it seems mrproper is used to clean everything
when kbuild is confused. But very often people want to keep their
.config. Dunno yet what to do, and for sure it makes no sense whatsoever
to mix a clean-up patch with a new functionality patch.

	Sam
