Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUBRE0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBRE0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:26:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63459 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263101AbUBREXt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:23:49 -0500
Date: Wed, 18 Feb 2004 04:23:40 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dave Jones <davej@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
Message-ID: <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston> <20040218040130.GC26304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218040130.GC26304@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 04:01:30AM +0000, Dave Jones wrote:
> On Wed, Feb 18, 2004 at 11:45:20AM +1100, Benjamin Herrenschmidt wrote:
> 
>  > BITFIELDS ARE EVIL !!!
>  > 
>  > Especially when mapping things like HW registers... I know the p/iSeries
>  > code is full of them, I'd strongly recommend getting rid of them.
>  > 
>  > The compiler is perfectly free, afaik, to re-order them
> 
> That can't be right surely ? That would make them utterly useless afaics.
> I've not seen this happen in practice either with the 2 x86 cpufreq drivers
> I wrote that both use bitfields extensively.

It _is_ right and they are utterly useless.  Original rationale was, indeed,
"describe the layout of hardware registers" but it had gone to hell may years
ago.  Any assumptions regarding their allocation are non-portable.
