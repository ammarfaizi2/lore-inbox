Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUAOVXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 16:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbUAOVXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 16:23:15 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:62686 "EHLO
	mwinf0203.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263596AbUAOVXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 16:23:07 -0500
Date: Thu, 15 Jan 2004 22:23:04 +0100
From: Romain Lievin <romain@rlievin.dyndns.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Subject: True story: "gconfig" removed root folder...
Message-ID: <20040115212304.GA25296@rlievin.dyndns.org>
References: <1074177405.3131.10.camel@oebilgen> <Pine.LNX.4.58.0401151558590.27223@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0401151558590.27223@serv>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Hi,
> 
> I only did a quick check with menuconfig. Are you sure it's really
> removed? It should still be there as "/root.old".
> I probably should change the behaviour of the save routine to behave
> differently for directories as argument, but it doesn't remove it.

I have managed to reproduce bug: make gconfig, go to the '/' directory,
type 'root' as file and ... you get a 'root' file. The 'root' directory is
destroyed !

> (Changing gconfig to only accept files in the save request would probably
> be nice too...)

I am preparing a patch for gconf so that it can be protected against this bug.
Perhaps, you should protect 'conf_write(fn)', too ?

> 
> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Romain Liévin (roms):         <roms@tilp.info>
Web site:                     http://tilp.info
"Linux, y'a moins bien mais c'est plus cher !"






