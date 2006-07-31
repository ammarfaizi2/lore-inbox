Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWGaXVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWGaXVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWGaXVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:21:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:62300 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030372AbWGaXVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:21:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMTTPxZl2VyUxhl9chCDSznyPU3TCWKJl+kuO+8JKBZ3H8ZpjSUBlNjOoEq0RWcVQSib0uAmBLIjevZV3E3Z7tHa3Xe70UUHMKzskeiDg4pGVd5V0xSNKoqR0ff9sdIKBeX9cjsGkVaaTsAdKYqs05uPUAfIPVppMkOEpaybhsE=
Message-ID: <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>
Date: Mon, 31 Jul 2006 16:21:28 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Cc: "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <44CE7C31.5090402@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
	 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	 <44CE7C31.5090402@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Matthias Andree <matthias.andree@gmx.de> wrote:
> Adrian Ulrich wrote:
>
> > See also: http://spam.workaround.ch/dull/postmark.txt
> >
> > A quick'n'dirty ZFS-vs-UFS-vs-Reiser3-vs-Reiser4-vs-Ext3 'benchmark'
>
> Whatever Postmark does, this looks pretty besides the point.

why's that?  postmark is one of the standard benchmarks...

> Are these actual transactions with the "D"urability guarantee?
> 3000/s doesn't look too much like you're doing synchronous I/O (else
> figures around 70/s perhaps 100/s would be more adequate), and cache
> exercise is rather irrelevant for databases that manage real (=valuable)
> data...

Data:
        204.62 megabytes read (8.53 megabytes per second)
        271.49 megabytes written (11.31 megabytes per second)

looks pretty I/O bound to me, 11.31 MB/s isn't exactly your latest DDR
RAM bandwidth.  as far as the synchronous I/O question, Reiser4 in
this case acts more like a log-based FS.  That allows it to "overlap"
synchronous operations that are being submitted by multiple threads.

NATE
