Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUKCAI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUKCAI1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbUKCAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:08:16 -0500
Received: from c-24-10-162-127.client.comcast.net ([24.10.162.127]:15747 "EHLO
	zedd.willden.org") by vger.kernel.org with ESMTP id S261308AbUKCADo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 19:03:44 -0500
From: Shawn Willden <shawn-lkml@willden.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
Date: Tue, 2 Nov 2004 17:03:39 -0700
User-Agent: KMail/1.7
References: <200411021551.53253.shawn-lkml@willden.org> <1099436816.9139.28.camel@cog.beaverton.ibm.com>
In-Reply-To: <1099436816.9139.28.camel@cog.beaverton.ibm.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021703.43453.shawn-lkml@willden.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the quick response, John.

On Tuesday 02 November 2004 04:06 pm, john stultz wrote:
> Does this go away if you disable cpufreq in your kernel config?

I'll try that next.

> Also, looking at /proc/interrupts, does it look like you're getting more
> then ~1000 interrupts per second?

I don't think so.  I'm not sure how to tell.  Running the following:

prev=0
while true; do
    cur=`cat /proc/interrupts| grep timer|cut -d' ' -f 6`
    (( diff = $cur - $prev ))
    echo $diff; prev=$cur
    sleep 1
done 

gives interrupt count differences that are between 1003 and 1222 per (rough) 
second.  The mean is 1016 with a std deviation of 16.  Running the same thing 
on another machine -- one without clock problems -- yields similar values.

Is there a better way to measure this?

Thanks

 Shawn
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiCBf6d8WxFy/CWcRAlkFAKCIVLcrXdMENi41SZ4jwSNx5Ukg2ACgjRPW
Ig1kUi1EwRw13ba+MVEVrFk=
=/KWj
-----END PGP SIGNATURE-----
