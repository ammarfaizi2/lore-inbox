Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269229AbTCBP2K>; Sun, 2 Mar 2003 10:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269230AbTCBP2K>; Sun, 2 Mar 2003 10:28:10 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:34244 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S269229AbTCBP2J>;
	Sun, 2 Mar 2003 10:28:09 -0500
Date: Sun, 2 Mar 2003 16:38:05 +0100
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce large stack usage
Message-ID: <20030302153805.GD27892@h55p111.delphi.afb.lu.se>
References: <20030301071007$18ea@gated-at.bofh.it> <200303021413.PAA12289@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303021413.PAA12289@post.webmailer.de>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18pVXR-0000Jy-00*6xoUwxmyOr.* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 02, 2003 at 03:11:40PM +0100, Arnd Bergmann wrote:
> broken, and I suspect huft_build/inflate_dynamic are the cause of the
> crashes I'm seeing during unpacking of initramfs.

I'm also seeing crashes when unpacking the initramfs if I enlarge it so it
takes more than a few (32kb) windows. I get crashes in a copy_from_user deep
down the callchain when it is doing the sys_write to a file in ramfs.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
