Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263691AbTLDXLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTLDXLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:11:09 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:4331 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263691AbTLDXLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:11:08 -0500
Date: Thu, 4 Dec 2003 23:10:15 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <200312041432.23907.rob@landley.net>
Message-ID: <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
References: <200312041432.23907.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Dec 2003, Rob Landley wrote:

> What are the downsides of holes?  [...] is there a performance penalty to
> having a file with 1000 4k holes in it, etc...)

Depends what you do, what fs you use. Using XFS XFS_IOC_GETBMAPX you might
get a huge improvement, see e.g. some numbers,

	http://marc.theaimsgroup.com/?l=reiserfs&m=105827549109079&w=2

The problem is, 0 general purpose (like cp, tar, cat, etc) util supports
it, you have to code your app accordingly.

	Szaka
