Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUHQOmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUHQOmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268267AbUHQOl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:41:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16004 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268257AbUHQOlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:41:55 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Date: Tue, 17 Aug 2004 16:40:31 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171512.26568.bzolnier@elka.pw.edu.pl> <20040817140533.GB2019@devserv.devel.redhat.com>
In-Reply-To: <20040817140533.GB2019@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171640.31986.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 16:05, Alan Cox wrote:
> > I hate HDIO_SCAN_HWIF and HDIO_UNREGISTER_HWIF and I still think we
> > should remove them - I waited with such changes for 2.7 but this plan
> > failed becuase there won't be 2.7 soon. :/
>
> Once you have drive and controller hot plug you don't need them. Until then
> some laptop users rely on them. I'd prefer to ignore the issue (its a
> privileged code path) until the hotplug is there, or patch it up by
> allowing unregister only of SCAN_HWIF added hwifs ?

IMO the correct approach is to remove them as a part of a patch series
which results in working hot plug support :)
