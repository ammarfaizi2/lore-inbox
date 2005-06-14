Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVFNXL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVFNXL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVFNXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:11:26 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:40399 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261404AbVFNXLP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:11:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FRsf240GH4b54Yj+p582EvhJF55YxZBlSN0hc0aKmJMLjZi+wiTJjDKekXxmFtqmWtvuNVS3LcvH3JMmXwblRffHJlctgLsEtHOiWE6Gt6Bn1tC5SiXy1BBK9sekpbhw/kaH9tv7CV+cWFfz4NUIYvIXyzV8Cxr1LNY4R3eFO7c=
Message-ID: <9e473391050614161117592eb5@mail.gmail.com>
Date: Tue, 14 Jun 2005 19:11:13 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Fwd: hpet patches
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004F782CB@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004F782CB@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> OK. I was thinking PCI fixup is to late in the initialization for
> HPET fixup. But, we should be OK with a new ACPI_FIXUP macro. My only
> other concern is, we should safely fallback to PIT, when our fixed_up
> HPET address isn't right.

If we're keying off from the PCI ID for the chip, how can it not have
the device? On the other hand, it would probably be good to always do
a little test on the HPET and fall back to the PIT if the HPET is
dead.

-- 
Jon Smirl
jonsmirl@gmail.com
