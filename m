Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbRFNPNd>; Thu, 14 Jun 2001 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263043AbRFNPNX>; Thu, 14 Jun 2001 11:13:23 -0400
Received: from geos.coastside.net ([207.213.212.4]:5585 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S263034AbRFNPNR>; Thu, 14 Jun 2001 11:13:17 -0400
Mime-Version: 1.0
Message-Id: <p05100306b74e83f6860f@[207.213.214.37]>
In-Reply-To: <3B28C6C1.3477493F@mandrakesoft.com>
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
 <3B28C6C1.3477493F@mandrakesoft.com>
Date: Thu, 14 Jun 2001 08:13:03 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Going beyond 256 PCI buses
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:14 AM -0400 2001-06-14, Jeff Garzik wrote:
>According to the PCI spec it is -impossible- to have more than 256 buses
>on a single "hose", so you simply have to implement multiple hoses, just
>like Alpha (and Sparc64?) already do.  That's how the hardware is forced
>to implement it...

That's right, of course. A small problem is that dev->slot_name 
becomes ambiguous, since it doesn't have any hose identification. Nor 
does it have any room for the hose id; it's fixed at 8 chars, and 
fully used (bb:dd.f\0).
-- 
/Jonathan Lundell.
