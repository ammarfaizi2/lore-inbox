Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUJFTI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUJFTI5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269392AbUJFTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:08:56 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:35500 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269390AbUJFTIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:08:55 -0400
Date: Wed, 6 Oct 2004 21:08:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-ID: <20041006190856.GE10153@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <1097087850.27683.3.camel@sherbert>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1097087850.27683.3.camel@sherbert>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: gianni@scaramanga.co.uk, akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 19:37:30 +0100, Gianni Tedesco wrote:
> 
> BTW. What happens if /dev/console or /dev/null are regular files?

Interesting point.  Any readers (init, some/all of it's children) will
read until one reaches EOF, all writers will flood it 'til it's full.
If there was an IOUAC (international obfuscated unix abuse contest),
you could use this for IPC, maybe.

> I don't see any check for this. I didn't think Linux imposed any
> namespace layout/ownership/permission requirements.

Anyone able to turn /dev/console into a regular file can already do
much worse things.  Don't think it's a security issue.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
