Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVDELjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVDELjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDELjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:39:54 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:7615 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261699AbVDELjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:39:53 -0400
Date: Tue, 5 Apr 2005 07:39:20 -0400
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
Message-ID: <20050405113920.GF10171@delft.aura.cs.cmu.edu>
Mail-Followup-To: Kay Sievers <kay.sievers@vrfy.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com> <20050405042329.GA10171@delft.aura.cs.cmu.edu> <200504042351.22099.dtor_core@ameritech.net> <1112689958.6702.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112689958.6702.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:32:38AM +0200, Kay Sievers wrote:
> On Mon, 2005-04-04 at 23:51 -0500, Dmitry Torokhov wrote:
> > Firmware loader is format-agnostic, I think having IHEX parser in a separate
> > file would be better...
> 
> Why should this be in-kernel at all? Convert the firmware into a binary
> blob or do it in the userspace request.

Because the keyspan headers seem to have a specific sequence of
operations, something like 'load these 5 bytes at offset 10, load this
byte at offset 0, etc.' I don't know if there is some magic in that
sequence. Without knowing what is in the firmware, it looks to me like a
little bit of bootstrap code is loaded first.

Jan
