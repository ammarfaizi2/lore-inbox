Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275929AbSIUSAQ>; Sat, 21 Sep 2002 14:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275930AbSIUSAQ>; Sat, 21 Sep 2002 14:00:16 -0400
Received: from 62-190-219-188.pdu.pipex.net ([62.190.219.188]:63492 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S275929AbSIUSAP>; Sat, 21 Sep 2002 14:00:15 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209211813.g8LIDEqQ001330@darkstar.example.net>
Subject: Re: hdparm -Y hangup
To: padraig.brady@corvil.com (Padraig Brady)
Date: Sat, 21 Sep 2002 19:13:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D8B2F8D.7030307@corvil.com> from "Padraig Brady" at Sep 20, 2002 03:24:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This seems like a bug in the ide driver not issuing a reset?
> 
> On RH7.3 (2.4.18-3) if I do:
> $ hdparm -Y /dev/hda
> $ do stuff and disk spins up
> $ hdparm -Y /dev/hda
> $ everything hangs waiting for disk

It *IS* a bug, but only Mark Lord, (the hdparm maintainer), and I seem to care about it - everybody else says, "just do hdparm -y instead", which is missing the point.

Incidently, I think you mean:

On RH7.3 (2.4.18-3) if I do:
$ hdparm -y /dev/hda
$ do stuff and disk spins up
$ hdparm -Y /dev/hda
$ everything hangs waiting for disk

with a lower case y for the first example.

So, unless you, I, or Mark Lord fixes it, it stays broken :-).

John.
