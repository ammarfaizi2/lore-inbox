Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbRFTVdA>; Wed, 20 Jun 2001 17:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbRFTVcl>; Wed, 20 Jun 2001 17:32:41 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12700 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263433AbRFTVcb>;
	Wed, 20 Jun 2001 17:32:31 -0400
Date: Wed, 20 Jun 2001 23:31:49 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106202131.XAA337370.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: [PATCH] remove null register_disk
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We will need register_disk().
> Reinserting it into the right places in 2.5 is a unnecessary PITA.

(i) today this is dead code
(ii) I am slowly restructuring all blockdev code, mainly with
the purpose of freeing partition code from the bowels of the
various drivers. In the process register_disk()
changes prototype, and grok_partitions() disappears.
For example, patch 06 that I made an hour or so ago
deletes the "minors" parameter of both. What, if anything,
will be reinserted later will be rather different from what
is there today. Indeed, these cdrom drivers do not need a
register_disk().

Andries

