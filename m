Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTAGCL3>; Mon, 6 Jan 2003 21:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTAGCL3>; Mon, 6 Jan 2003 21:11:29 -0500
Received: from hera.cwi.nl ([192.16.191.8]:249 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267261AbTAGCL2>;
	Mon, 6 Jan 2003 21:11:28 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 7 Jan 2003 03:19:45 +0100 (MET)
Message-Id: <UTC200301070219.h072JjD19965.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, patmans@us.ibm.com
Subject: Re: IDs
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-kernel@one-eyed-alien.net,
       zwane@holomorphy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can tell if the id sdev->name should be unique by looking at
> the first byte (it is not unique if the value is 'Z'),
> SCSI_UID_UNKNOWN.

Such things are nontrivial.

% cat /sysfs/devices/ide-scsi/0:0:0:0/0:0:0:0/name
SHP      CD-Writer+ 8200 [

Here the serial number consists of the '[' only.
(And this is not because of truncation.)

I can see your intentions, but view these names/ids more
like heuristics than like reliable data.
More or less like mount, which will usually figure out the
filesystem type for you, but no guarantees are given.

And where we have heuristics only, it cannot be "wrong"
to truncate at 50 positions or so. The heuristic does
not become appreciably weaker.

(And, in case of heuristics, I like 98% heuristics better
than 99.98% heuristics. They keep you honest. No important
things will depend upon them. With 99.98% one may forget
that it is a heuristic.)

Andries
