Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVBWWFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVBWWFJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVBWWDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:03:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:26181 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261626AbVBWWBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:01:48 -0500
To: Prakash Punnoor <prakashp@arcor.de>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Lord <mlord@pobox.com>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
X-Message-Flag: Warning: May contain useful information
References: <421CE018.5030007@pobox.com>
	<200502232345.23666.adobriyan@mail.ru> <421CF575.20801@arcor.de>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 23 Feb 2005 14:01:44 -0800
In-Reply-To: <421CF575.20801@arcor.de> (Prakash Punnoor's message of "Wed,
 23 Feb 2005 22:28:21 +0100")
Message-ID: <528y5faqbb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Feb 2005 22:01:45.0073 (UTC) FILETIME=[43890E10:01C519F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Prakash> If I am not totally mistaken this is not gcc4 friendly
    Prakash> code. (lvalue thing...)

Actually you misread the code slightly.  It's a little subtle, but
code like

		*(__le32 *)prd = cpu_to_le32(len);

is not using a cast as an lvalue.  It's dereferencing a cast and as
such is totally correct, idiomatic and clean C.

 - Roland
