Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUGHS06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUGHS06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUGHS06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:26:58 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:35049 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261451AbUGHS05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:26:57 -0400
Date: Thu, 8 Jul 2004 20:26:54 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Increasing IDE Channels
Message-ID: <20040708182654.GA10246@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040707225635.GA26832@dreamland.darkstar.lan> <40ED6F1A.7080101@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED6F1A.7080101@techsource.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Jul 08, 2004 at 11:58:18AM -0400, Timothy Miller ha scritto: 
> >Because hwifs are statically allocated, see drivers/ide/ide.c:
> >
> >ide_hwif_t ide_hwifs[MAX_HWIFS];        /* master data repository */
> >
> >Also if names are ide0..ide9, the following would be ide: and ide; (see
> >init_hwif_data in drivers/ide/ide.c).
> >
> 
> Why wouldn't they be ide10 and ide11?

No:

static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
{
        ...
        hwif->name[0]   = 'i';
        hwif->name[1]   = 'd';
        hwif->name[2]   = 'e';
        hwif->name[3]   = '0' + index;

'0' + 10 is ':' and '0' + 11 is ';'

Luca
-- 
Home: http://kronoz.cjb.net
Porc i' mond che cio' sott i piedi!
V. Catozzo
