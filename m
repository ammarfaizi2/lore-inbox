Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTLEACd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbTLEACc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 19:02:32 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:901 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263762AbTLEACb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 19:02:31 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Szakacsits Szabolcs <szaka@sienet.hu>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 4 Dec 2003 18:02:52 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net> <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
In-Reply-To: <Pine.LNX.4.58.0312042300550.2330@ua178d119.elisa.omakaista.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041802.52067.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 15:10, Szakacsits Szabolcs wrote:
> On Thu, 4 Dec 2003, Rob Landley wrote:
> > What are the downsides of holes?  [...] is there a performance penalty to
> > having a file with 1000 4k holes in it, etc...)
>
> Depends what you do, what fs you use. Using XFS XFS_IOC_GETBMAPX you might
> get a huge improvement, see e.g. some numbers,
>
> 	http://marc.theaimsgroup.com/?l=reiserfs&m=105827549109079&w=2
>
> The problem is, 0 general purpose (like cp, tar, cat, etc) util supports
> it, you have to code your app accordingly.

Okay, I'll bite.  How would one go about adding hole support to cat? :)

Adding hole support to busybox's cp and tar is on my to-do list.  (Pretty far 
down on the list, but still...)

> 	Szaka

Rob
