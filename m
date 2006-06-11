Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWFKDRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWFKDRD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 23:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbWFKDRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 23:17:03 -0400
Received: from trinity.phys.uwm.edu ([129.89.57.159]:16584 "EHLO
	trinity.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S1161071AbWFKDRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 23:17:01 -0400
Date: Sat, 10 Jun 2006 22:15:59 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
X-X-Sender: ballen@trinity.phys.uwm.edu
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, apiszcz@solarrain.com,
       smartmontools-support@lists.sourceforge.net,
       Remy Card <Remy.Card@linux.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@alum.mit.edu>,
       David Beattie <dbeattie@softhome.net>
Subject: Re: [smartmontools-support] The Death and Diagnosis of a Dying Hard
 Drive - Is S.M.A.R.T. useful?
In-Reply-To: <Pine.LNX.4.64.0606100658130.26702@p34.internal.lan>
Message-ID: <Pine.LNX.4.62.0606102212060.17718@trinity.phys.uwm.edu>
References: <Pine.LNX.4.64.0606100615500.15475@p34.internal.lan>
 <20060610105141.GE30775@lug-owl.de> <Pine.LNX.4.64.0606100658130.26702@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin,

It's an unfortunate fact of life that SMART will not detect all disk 
failures.  My research group in the U. Wisconsin - Milwaukee Physics 
Department runs two large computing clusters (approximately 2000 hard 
disks total).  We run weekly extended self-tests with smartd.  Our 
experience over about five years is that about 2/3 of drive failures can 
are predicted by smartd.  The other 1/3 of failures have no warning.

I am surprised that the extended self-test does not detect the bad sectors 
on your disk.  Our experience is that the typical SYSLOG 'seek failure' 
error messages do correlate very well with the failing LBAs found via 
SMART self-tests.

On your disk, it may be the case that these bad sectors are *sometimes* 
readable, or that the sequential scanning done during a SMART self-test do 
not provoke these errors.  If you have some time to follow up, you could 
do some experiments with a recent release of dd using the 'direct' option 
to bypass the block layers in the Linux kernel.

Cheers,
       Bruce
