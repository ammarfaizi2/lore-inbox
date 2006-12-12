Return-Path: <linux-kernel-owner+w=401wt.eu-S1750955AbWLLIUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWLLIUa (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 03:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWLLIUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 03:20:30 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:47593 "HELO
	smtp111.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750949AbWLLIU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 03:20:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=zOulqwRMKY2fnb1D3QpVS7uPfeFbxJtmICwA6ZTnlE7oqgWMzr69ldtfNnA4txI8m2JjpKaMZmGX3IzK+x//aiDzNYw2Q6cvUqMyPLJaJ6/sdTuzs7w1XvPT/NVNz17espNIWljEobs1vpJ56lfgWvU9Yn51PWIcQhvwXeh3ycA=  ;
X-YMail-OSG: 2mmaesUVM1lPpXMHKH3CUhgIHnZkLSQXl4kEwFtZh73DXQmrgyXNsPVf31cpo6mX17YZloZlnezGJik6_exMM.m1PGWw2yFm9k693Ca1q4va3ZLnMFmLgQQd4boyKE8cpFFBw8N8MTiB71g-
From: David Brownell <david-b@pacbell.net>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [patch 2.6.19-git] rts-rs5c372 updates: more chips, alarm, 12hr mode, etc
Date: Tue, 12 Dec 2006 00:20:18 -0800
User-Agent: KMail/1.7.1
Cc: "Voipio Riku" <Riku.Voipio@movial.fi>, rtc-linux@googlegroups.com,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "Alessandro Zummo" <alessandro.zummo@towertech.it>, i2c@lm-sensors.org
References: <200612081859.42995.david-b@pacbell.net> <42003.80.222.56.248.1165875783.squirrel@webmail.movial.fi> <e9c3a7c20612111533o75683c2j30dbf440696932a6@mail.gmail.com>
In-Reply-To: <e9c3a7c20612111533o75683c2j30dbf440696932a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612120020.20139.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 December 2006 3:33 pm, Dan Williams wrote:
> 
> According to the latest specification update
> (http://www.intel.com/design/iio/specupdt/27351910.pdf) there are no
> known issues with the i2c. 

That's for the 80319 ... Riku said he was using 80219, that
could imply some differences.  And I distinctly recall Intel's
XScale docs having a few problems whereby "live" silicon bugs
didn't always stay in the "spec update" documents, so it's
possible that older docs would be needed.

At this point all we really _know_ is that requests made
through 80219's i2c controller don't give the correct result
(at least on Riku's 80219 board) and moreover seem to have a
consistent failure mode ... whereas ones made with OMAP's
controller (and presumably that of the original driver author,
for a Synology DS-101 presumably with IXP420) do act ok.

- Dave

