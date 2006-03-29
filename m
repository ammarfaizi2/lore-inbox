Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWC2E4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWC2E4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWC2E4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:56:08 -0500
Received: from sputnik.senvnet.fi ([80.83.5.69]:6352 "EHLO sputnik.senvnet.fi")
	by vger.kernel.org with ESMTP id S1750820AbWC2E4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:56:07 -0500
Date: Wed, 29 Mar 2006 07:56:03 +0300 (EEST)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senvnet.fi
To: Paul Risenhoover <prisenhoover@daxsolutions.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: BUG: soft lockup detected on CPU#0!
In-Reply-To: <4429A027.1010509@daxsolutions.com>
Message-ID: <Pine.LNX.4.62.0603290748240.22034@mir.senvnet.fi>
References: <4429A027.1010509@daxsolutions.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1397768965-39367188-1143608163=:22034"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1397768965-39367188-1143608163=:22034
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Mar 2006, Paul Risenhoover wrote:

> I have been experiencing a number of networking issues with three 
> new machines I have purchased.  They are Dell SC1425 machines, each 
> with two 64-bit processors.  I have attached the dmesg log to this 
> email for your review.

Although not it is possibly not directly related to your problem, 
I've also experienced soft lockups on CPU#0 with a Dell PE1850 running
Xen unstable and 2.6.16. The BUG caused the machine to instantly 
crash and was 100% reproducible by starting an ftp transfer from
a fast server.

After spending a good portion of the day pulling my hair out, I 
figured out that the USB controller in Dell PowerEdges is really 
flaky and had caused similar problems before. Disabling the USB 
controller from BIOS made my problem go away.

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-
--1397768965-39367188-1143608163=:22034--
