Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWCAD5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCAD5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWCAD5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:57:07 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:2361 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751102AbWCAD5G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:57:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TC55WzJ4aIaSyihSv0rtPvaWO1lXDT5iCbLnphdIe2//5tmRWycAlUkC9Oc6a/+egbHnh9RfFQqUYKjqFZS62A3sba0phTZQ/mvodfMhjHAajYHgBP9uath/wDQePtwSHYOpZfb348XmeqEjstsotadMnmTvf7eoWgvstfeEToU=
Message-ID: <dc1166600602281957h4158c07od19d0e5200d21659@mail.gmail.com>
Date: Wed, 1 Mar 2006 14:57:05 +1100
From: "Michael Ellerman" <michael@ellerman.id.au>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH] leave APIC code inactive by default on i386
Cc: linux-kernel@vger.kernel.org, "Chris McDermott" <lcm@us.ibm.com>
In-Reply-To: <43D03AF0.3040703@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43D03AF0.3040703@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Darrick J. Wong <djwong@us.ibm.com> wrote:
> Hi there,
>
> Some old i386 systems have flaky APIC hardware that doesn't always work
> right.  Right now, enabling the APIC code in Kconfig means that the APIC
> code will try to activate the APICs unless 'noapic nolapic' are passed
> to force them off.  The attached patch provides a config option to
> change that default to keep the APICs off unless specified otherwise,
> disables get_smp_config if we are not initializing the local APIC, and
> makes init_apic_mappings not init the IOAPICs if they are disabled.
> Note that the current behavior is maintained if
> CONFIG_X86_UP_APIC_DEFAULT_OFF=n.

...

Did this hit the floor? It strikes me as a pretty good solution. This
is pretty nasty for newbies installing distro kernels, they get some
of the way through an install and then their machine just locks - not
good PR.

cheers
