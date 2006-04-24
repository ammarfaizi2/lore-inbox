Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWDXRj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWDXRj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWDXRj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:39:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37766 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751045AbWDXRj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:39:26 -0400
Subject: RE: Problems with EDAC coexisting with BIOS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: bluesmoke-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Ong, Soo Keong" <soo.keong.ong@intel.com>,
       "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
In-Reply-To: <5389061B65D50446B1783B97DFDB392DA23445@orsmsx411.amr.corp.intel.com>
References: <5389061B65D50446B1783B97DFDB392DA23445@orsmsx411.amr.corp.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 18:49:42 +0100
Message-Id: <1145900982.1635.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 08:57 -0700, Gross, Mark wrote:
> I think what I'm saying is pretty clear and I don't think it is related
> to whatever workarounds where done earlier.

Ok. I was concerned as I seem to remember an earlier errata fix enabled
the memory controller temporarily to do a workaround on one bridge. We
hit this because it unconditionally disabled it afterwards and Intel
sent fixes for RHEL4. I don't believe the workaround in question is in
the current tree as it was fixed elsewhere.

Just worried that if that is the case an SMI the wrong moment might fail
to apply the workaround.


> >Why did Intel bother implementing this functionality and then screwing
> >it up so that OS vendors can't use it ? It seems so bogus.
> >
> 
> It was just a screw up not to have identified this issue sooner.  

Ok. So the intention was that the OS should also be able to access this
material.

> >At the very least we should print a warning advising the user that the
> >BIOS is incompatible and to ask the BIOS vendor for an update so that
> >they can enable error detection and management support.
> 
> I would place the warning in the probe or init code.

Agreed, and then bale out. Customer pressure should do the rest if the
BIOS needs updating, or ACPI or similar need to grow a 'shared' API for
this so the BIOS and OS can co-operate.

Alan

