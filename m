Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWG2Ka7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWG2Ka7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 06:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422739AbWG2Ka7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 06:30:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:62128 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422738AbWG2Ka5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 06:30:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AWBfLwuWV06PfA1bgxh8qNz80QfH7MIzOleMB/iBnMXIdoYv6eTMjvF8hAvT5vyk3KVMak0T4oLYsSRi++y9mJLLxzIOlq+m6V1zY000+H3lb5l4c1Za+Ht6GefWrqU7WvJVqozBoLjTFCQMeK7pHjcMDMIQHF6EhXesQvXw9zo=
Message-ID: <41840b750607290330t35eab99fscef30fb46fdf4ec0@mail.gmail.com>
Date: Sat, 29 Jul 2006 13:30:56 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Pavel Machek" <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060729101730.GA7438@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727232427.GA4907@suse.cz> <20060728074202.GA4757@suse.cz>
	 <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz>
	 <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
	 <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
	 <41840b750607281510j2c5babf8x9fac51fe6910aeda@mail.gmail.com>
	 <200607282314.k6SNESSg019274@turing-police.cc.vt.edu>
	 <41840b750607290248r5999d1fen41f9d3044d385857@mail.gmail.com>
	 <20060729101730.GA7438@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > The lazy polling approach I described in my last post to Vojtech
> > ("block until there's  a new readout or N milliseconds have passed,
> > whichever is later") looks like a more general, accurate and efficient
> > interface.
>
> If "N" is given by the kernel, then it's identical to an event-based
> approach. ;) Just described in different words.

No, N is given separately by each userspace client, on every call.
That's the whole point. The kernel driver then does the minimal
hardware querying and event generation that (a) makes sense for the
hardware and (b) satisfies all userspace clients.

  Shem
