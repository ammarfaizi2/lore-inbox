Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbUKGGEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUKGGEs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 01:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbUKGGEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 01:04:48 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:7413 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261542AbUKGGEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 01:04:45 -0500
Date: Sat, 6 Nov 2004 22:04:27 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] WIN_* -> ATA_CMD_* conversion (take #2): comments
Message-ID: <20041107060427.GA25569@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032305.GB6060@taniwha.stupidest.org> <418D0066.9040002@pobox.com> <418D043E.3090406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418D043E.3090406@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 12:05:02PM -0500, Jeff Garzik wrote:

> Please check with ATA/ATAPI-7 command names, rather than just using
> the WIN_xxx names with a new prefix.  Sometimes the IDE author (from
> ages past) would pick names that suited them or the code, but
> diverged from the common T13 command name.

Fair enough

> 7) some are old ATA-2-era commands, some are vendor-specific
> commands.  Not much you can do about the naming of these.

Left behind with the exception of two that the spec calls obsolete
(end of table 65 & 66 in the v7 spec I have here)

> 8) remove all xxx_ONCE that are not used

gone

> 9) hdreg.h lists commands in opcode value order

ata.h doesn't have a numeric order though, so i just grouped things
semi-logically for now

> 10) Kill WIN_SRST (dups properly named WIN_DEVICE_RESET)

now ATA_CMD_DEVICE_RESET



note, the following three patches use the names from the spec
verbatim, which makes them a bit long and ugly but not terribly so...
i'm not bothered by them personally and they are not used in that many
places so IMO they should be acceptable as-is ... yes, i know it makes
the formatting of ata.h look funny, but that was bogus anyhow :)
