Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUDVLUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUDVLUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 07:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbUDVLUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 07:20:09 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:20125 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S263943AbUDVLUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 07:20:06 -0400
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
To: arjanv@redhat.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF83E740E9.CE27150D-ONC1256E7E.002EED0D-C1256E7E.00305B60@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 10:48:11 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 10:48:13
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> is this generally useful, eg can all architectures use the
> infrastructure you propose ? I seriously hope so; s390 isn't the only
> one who would benefit, I'd love to see a generic thing for this.

It is. All you have to do is to rework the timer functions for the
architecture you want to support. This can be quite complicated
though. There are some subtle races if you want to switch of the
100 HZ timer for a cpu. We had some problem with cpus that didn't
want to wake up anymore ...

blue skies,
   Martin

