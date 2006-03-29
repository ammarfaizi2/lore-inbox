Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWC2DIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWC2DIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 22:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWC2DIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 22:08:18 -0500
Received: from canuck.infradead.org ([205.233.218.70]:26247 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbWC2DIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 22:08:17 -0500
Message-ID: <4429F9F9.9000403@torque.net>
Date: Tue, 28 Mar 2006 22:07:37 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
CC: "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: I/O performance measurement tools on Linux
References: <890BF3111FB9484E9526987D912B261901BC88@NAMAIL3.ad.lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261901BC88@NAMAIL3.ad.lsil.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote:
> Hi,
> 
> Are there any performance measurement tools available that running on
> Linux?
> I would like to measure disk I/O performance (file system and raw I/O)
> on several kernels.
> Please lead me to the place.

The sg3_utils package may help with some raw SCSI
and SATA disk I/O measurements.
sg_dd, sgp_dd and sgm_dd are dd variants that
let you tweak a lot of low level details. The sg_read
utility can be used to measure disk cache throughput,
transport speeds and command overhead.

Recently I have been looking at measuring command overhead.
On the disks that I am testing a zero block READ (i.e.
issue a SCSI READ for zero blocks) is the fastest command.

The most recent released sg3_utils can be found at:
http://www.torque.net/sg   [Utilities section]
The latest beta is in the news section of that page.
A description can be found at:
http://www.torque.net/sg/u_index.html

Doug Gilbert



