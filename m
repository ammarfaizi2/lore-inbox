Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbSJFUCb>; Sun, 6 Oct 2002 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262176AbSJFUCb>; Sun, 6 Oct 2002 16:02:31 -0400
Received: from fusion.wineasy.se ([195.42.198.105]:43013 "HELO
	fusion.wineasy.se") by vger.kernel.org with SMTP id <S262167AbSJFUC3>;
	Sun, 6 Oct 2002 16:02:29 -0400
Date: Sun, 6 Oct 2002 22:08:01 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: linux-kernel@vger.kernel.org
Subject: kdb against memory corruption?
Message-ID: <20021006200801.GD1316@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think i found a case of memory corruption in the backport of
the linuxconsole-ruby patch to 2.4.19.

Some parts (not sure which yet) of the tty_struct get
overwritten. I do not yet know when that happens or how, but i
intend to find out with kdb and its bph brakepoint feature.

Unfortunatly my initial attempts to find the instance where the
memory segment gets corrupted failed. I specified a certain
address, a length of 4 byte and DATAW as arguments to the bph
command.

but reading the kdb manpage i get the impression that
startaddress and length have to match precisly:

DATAW   Enters  the  kernel  debugger  when  data of length
        length is written to the specified address.

how can i use this to find the cause of the corruption? Anyone
done this before? i would want to be alerted whenever anything
withing a certain memory range gets overwritten.
