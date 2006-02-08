Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWBHGp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWBHGp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWBHGpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:45:53 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:1722 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161026AbWBHGpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:45:09 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Date: Wed, 8 Feb 2006 07:46:09 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux PM <linux-pm@osdl.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200602071906.55281.ncunningham@cyclades.com> <200602080040.41495.dtor_core@ameritech.net>
In-Reply-To: <200602080040.41495.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080746.10524.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 06:40, Dmitry Torokhov wrote:
> On Tuesday 07 February 2006 04:06, Nigel Cunningham wrote:
> > Hi all.
> > 
> > This patch is designed to help with diagnosing and fixing the cause of
> > problems in suspending/resuming, due to drivers wrongly re-enabling
> > interrupts in their .suspend or .resume methods. 
> > 
> > I nearly forgot about it in sending patches in suspend2 that might help
> > where swsusp fails.
> > 
> 
> Only sysdevs are guaranteed to be suspebded/resumed with interrupts off,
> other devices are suspended with interrupts on (at least on first pass
> over device list).

Yes, and AFAICT this is how it's supposed to be.  [There was an LKML thread
last year that finished with this conclusion.  I think I can find it for reference,
if necessary.]

Greetings,
Rafael
