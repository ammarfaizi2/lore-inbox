Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWJXLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWJXLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 07:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWJXLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 07:09:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26024 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWJXLJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 07:09:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fVg3xgskJH35DiIjMMB3LcaEj7wQI9F70SYxG4GDVYlu7nIdpXTjGbj5F5dm0jVPoZVumuzHCtS6CGi28cOYJuGUT1L8Ia5cdWEdTYeDXR0tiZsgHw2+FUH1wwF0qj74cfTvzbAtYnCGCCpMG3dISIcs3NqvZJix0aKUrNoqbd8=
Message-ID: <41840b750610240409g1dfd35e5vd9abcb2f6ea1ab1e@mail.gmail.com>
Date: Tue, 24 Oct 2006 13:09:47 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Matthew Garrett" <mjg59@srcf.ucam.org>
Subject: Re: Battery class driver.
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "David Zeuthen" <davidz@redhat.com>,
       "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       olpc-dev@laptop.org, greg@kroah.com, len.brown@intel.com,
       sfr@canb.auug.org.au
In-Reply-To: <20061024035346.GA24538@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161627633.19446.387.camel@pmac.infradead.org>
	 <1161641703.2597.115.camel@zelda.fubar.dk>
	 <41840b750610231956ib1c7204tafb23ecd76f5d9d2@mail.gmail.com>
	 <20061024032704.GA24320@srcf.ucam.org>
	 <1161661707.10524.547.camel@localhost.localdomain>
	 <20061024035346.GA24538@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> The kernel backend or the userspace backend? We need to decide on
> terminology :) There's no good programmatic way of determining how long
> a query will take other than doing it and looking at the result. I guess
> we could do that at boot time.

This is up to the kernel driver. Most drivers have fairly accurate
knowledge about the hardware they read, in terms of both the cost of
reading and the rate of change that's worth tracking.

The important thing is to define an ABI convention that lets userspace
tell the driver when it wants the next refresh (via either David's
timestamp or my suggested ioctl). The driver can then make its
informed decision on how to reasonably fulfill the request.

  Shem
