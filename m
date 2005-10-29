Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVJ2RIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVJ2RIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVJ2RIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:08:48 -0400
Received: from ns1.suse.de ([195.135.220.2]:4226 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbVJ2RIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:08:47 -0400
From: Andi Kleen <ak@suse.de>
To: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
Date: Sat, 29 Oct 2005 18:41:48 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, haveblue@us.ibm.com
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi> <Pine.OSF.4.61.0510291312160.426625@rock.it.helsinki.fi> <Pine.OSF.4.61.0510291749360.404250@rock.it.helsinki.fi>
In-Reply-To: <Pine.OSF.4.61.0510291749360.404250@rock.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510291841.49214.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 October 2005 16:54, Janne M O Heikkinen wrote:
> On Sat, 29 Oct 2005, Janne M O Heikkinen wrote:
> 
> > No, I get same panics with numa=noacpi or even with numa=off. If I compile
> > 2.6.14 kernel without CONFIG_ACPI_NUMA it does boot.
> 
> It wasn't removing of CONFIG_ACPI_NUMA that made it boot after all, I had
> also changed memory model from "Sparse" to "Discontiguous". And now
> when I recompiled with CONFIG_ACPI_NUMA=y and with "Discontiguous" memory
> model it booted just fine.

Ok, that would explain it. I never test sparse, only discontiguous.
sparse is only an experimental option that is not really maintained
yet. 	Probably need to disable it if it's broken.

Perhaps Dave H. knows what to do with it.

-Andi

