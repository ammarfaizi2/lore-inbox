Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263688AbTDTTpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263690AbTDTTpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 15:45:15 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7553 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263688AbTDTTpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 15:45:15 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304202000.h3KK0GsX000976@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 20 Apr 2003 21:00:16 +0100 (BST)
Cc: skraw@ithnet.com (Stephan von Krawczynski),
       john@grabjohn.com (John Bradford),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1050864521.11658.8.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 20, 2003 07:48:42 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I know you favor a layer between low-level driver and fs
> > probably. Sure it is clean design, and sure it sounds like
> > overhead (Yet Another Layer).
> 
> Wrong again - its actually irrelevant to the cost of mirroring data, the cost
> is entirely in the PCI and memory bandwidth. The raid1 management overhead is
> almost nil

Actually what I was suggesting was even simpler - in the unlikely
event that we were talking about an MFM or similar interface disk that
_was_ basically like a big floppy, and did no error correction of it's
own, we _could_ reserve, say, one sector per track, and create a 
fault tollerant device that substituted the spare sector in the event
of a write fault.

The overhead would probably be exactly zero, becuase nobody would
actually compile the feature in and use it :-).

John.
