Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTHSHZs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 03:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHSHZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 03:25:48 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37504 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262273AbTHSHZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 03:25:47 -0400
Date: Tue, 19 Aug 2003 08:37:31 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308190737.h7J7bVaa000623@81-2-122-30.bradfords.org.uk>
To: herbert@13thfloor.at
Subject: Re: [OT] Documentation for PC Architecture
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've done some tests with a simple kernel which I wrote: all that region 
> > (except video memory at 0xb8000) results "read only"...
>
> because it is usually designated as rom area, which naturally
> is read only ... 

On some boards I've seen, there is 384K onboard for ROM shadowing
purposes, and when only 128K is actually used, (as it is in a lot of
configurations), the other 256K is available as system memory.

However, this on-board 256K is only remapped when you have 8 MB RAM or
less on the board.  So with 8 MB the board reports 8448K of RAM, but
with 16 MB, it only reports 16384K.  In that case 256K of real RAM is,
indeed, lost.

John.
