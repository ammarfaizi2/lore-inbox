Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264632AbUEOADy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbUEOADy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUEOADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:03:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:38285 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S264632AbUEOAAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:00:54 -0400
Date: Sat, 15 May 2004 01:00:43 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Andy Lutomirski <luto@myrealbox.com>
cc: Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] capabilities
In-Reply-To: <40A2D449.7090103@myrealbox.com>
Message-ID: <Pine.LNX.4.58.0405150057580.1979@fogarty.jakma.org>
References: <200405112024.22097.luto@myrealbox.com> <20040512164132.2d30dac2.akpm@osdl.org>
 <40A2D449.7090103@myrealbox.com>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 May 2004, Andy Lutomirski wrote:

> Like something that turns KEEPCAPS on then setuid()s then executes
> an untrusted program?  It's obviously wrong, but it's secure
> currently since the exec wipes capabilities.  And no one would
> notice.  Ugh!

Definitely wrong. 

> The prctl would defeat the purpose (imagine if bash forgot the
> prctl -- then the whole thing is pointless).

Capabilities aware programmes are most likely already setting
PR_SET_KEEPCAPS anyway if they're doing anything half-fancy. Another 
prctl() wont hurt too much if it is the only way to guarantee 
backward compatible security (?).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
"I go on working for the same reason a hen goes on laying eggs."
- H. L. Mencken
