Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264029AbUEDUio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbUEDUio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbUEDUio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 16:38:44 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49145 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S264029AbUEDUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 16:38:43 -0400
Date: Tue, 4 May 2004 13:38:40 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: RE: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040504203840.GA2102@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen Martin wrote:
> This will require changing the value for register at bus:0 dev:0 func:0
> offset 6c.
>
> Chip   Current Value   New Value
> C17       1F0FFF01     1F01FF01
> C18D      9F0FFF01     9F01FF01
>
> Northbridge chip version may be determined by reading the PCI revision
> ID (offset 8) of the host bridge at bus:0 dev:0 func:0.  C1 or greater
> is C18D.

I believe I have confirmed that the Shuttle AN35N BIOS indeed has this fix as
of Dec 5th 03 version.

lspci -xxx -vvv
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev c1)
...
60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 01 9f

Jesse

