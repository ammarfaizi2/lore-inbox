Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965141AbVHZRgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965141AbVHZRgg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVHZRgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 13:36:36 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:15074 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965141AbVHZRgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 13:36:35 -0400
Date: Fri, 26 Aug 2005 12:35:08 -0500
From: serue@us.ibm.com
To: Chris Wright <chrisw@osdl.org>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>, Stephen Smalley <sds@epoch.ncsc.mil>,
       linux-security-module@wirex.com
Subject: Re: [PATCH 0/5] LSM hook updates
Message-ID: <20050826173508.GA11489@sergelap.austin.ibm.com>
References: <20050825012028.720597000@localhost.localdomain> <Pine.LNX.4.63.0508250038450.13875@excalibur.intercode> <20050825053208.GS7762@shell0.pdx.osdl.net> <20050825191548.GY7762@shell0.pdx.osdl.net> <20050826092306.GA429@sergelap.austin.ibm.com> <20050826164139.GK7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826164139.GK7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> > A little surprising: kernbench is improved, but dbench and tbench
> > are worse - though within the 95% CI.
> 
> It is interesting.  Would be good to see what happens with the cap_ bits
> used in SELinux instead of secondary callout.

Here are the new numbers next to the originals.  'patchedv2' is
obviously with your new patch.  Kernbench keeps getting faster :)

dbench (throughput, larger is better):
original:  357.957780 +/- 3.509188
patched:   351.266820 +/- 4.736168
patchedv2: 352.414880 +/- 3.649639

tbench (throughput, larger is better):
original:  38.710270 +/- 0.028970
patched:   38.210506 +/- 0.032954
patchedv2: 38.018038 +/- 0.024762

kernbench (time, smaller is better):
original:  91.837000 +/- 0.324471
patched:   91.466000 +/- 0.308797
patchedv2: 91.079000 +/- 0.236836

reaim (#children vs throughput, larger is better):

original:
1 48702.197000 1875.223996
3 131411.870000 4497.107969
5 130219.174000 6365.289551
7 162377.027000 3131.071134
9 155432.904000 4964.935291
11 169784.384000 4490.812272
13 164540.169000 3902.652904
15 172983.569000 3149.934591

patched:
1 47525.273000 1509.578035
3 132151.651000 2282.043786
5 131244.291000 5874.212092
7 165629.693000 4646.641230
9 156163.110000 3422.903849
11 170608.526000 4132.988693
13 164863.102000 3664.214481
15 172947.803000 2548.662380

patchedv2:
1 46796.702000 1454.752458
3 126771.430000 3296.287229
5 132779.408000 4786.218275
7 165525.949000 3364.383587
9 156160.772000 3358.822121
11 172681.856000 2524.954098
13 162618.395000 4892.710796
15 172982.170000 3105.761847

> Also, need to run ia64,
> do you have an ia64 box?

Not a one, I'm afraid.

-serge
