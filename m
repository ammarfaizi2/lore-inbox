Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWGaBeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWGaBeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 21:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaBeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 21:34:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30173 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932115AbWGaBeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 21:34:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WusBUaPfiQs8CtlM2isdgnO/EsOgcnA7eamdo5nLNb1hXiE6+vig+US6ZZ6I7jA8nLHyTJsA7Nqy4veoZW2UgkDR1DMvr6j/Qj9QaXZfmUi1ifxrZVcKh+kvlxLmRcTvhUN9ggHndyLxuX4/ggtiRU/R1CCAI/Nu5wWeH+d8nDU=
Message-ID: <41840b750607301834g6e7cedbj179ad12206c10529@mail.gmail.com>
Date: Mon, 31 Jul 2006 04:34:15 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Pavel Machek" <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <200607310058.k6V0wYj2004593@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
	 <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
	 <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
	 <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <200607300835.k6U8ZvSB016669@turing-police.cc.vt.edu>
	 <41840b750607300448u353a3276o8c30d7d880da6329@mail.gmail.com>
	 <200607310058.k6V0wYj2004593@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> OK, if you meant this one (that hadn't shown up here before I hit 'send'):

No, I ment this one: http://lkml.org/lkml/2006/7/30/193
(or actually its parent, at the time).


> was commenting about.  A gkrellm-ish program can query every 100ms and
> get a cached value 49 times out of 50 for a value that's hardware-updated
> every 5 seconds, and all will be well (of course, there's room for some
> added optimization,

That's exactly what we're trying to avoid -- excessive polling of
values that don't change. It causes unnecessary system load and timer
interrupts on tickless kernels.


> unless the kernel has
> a good way to pass back a good hint of when the next update will be...)

The kernel often doesn't know when it will get the next update. But on
the other hand, apps usually know well in advance  when they'll *want*
the next update. My proposal exploits this to get optimal behavior (if
the driver+infrastructure do the right thing).

  Shem
