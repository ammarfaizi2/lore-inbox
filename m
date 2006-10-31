Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423247AbWJaNaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423247AbWJaNaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423245AbWJaNaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:30:24 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:58858 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1423247AbWJaNaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:30:23 -0500
Message-ID: <45474FF3.2010200@cfl.rr.com>
Date: Tue, 31 Oct 2006 08:30:27 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Debugging I/O errors further?
References: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net> <453960B3.6040006@gmail.com> <D3D931E5-0EA7-4CC4-A59D-364C65335DBA@karlsbakk.net> <A9AF211A-08C8-4FC4-8280-D3AA3136FF3B@karlsbakk.net>
In-Reply-To: <A9AF211A-08C8-4FC4-8280-D3AA3136FF3B@karlsbakk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2006 13:30:30.0686 (UTC) FILETIME=[BC394BE0:01C6FCF0]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14784.003
X-TM-AS-Result: No--11.605900-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only idea I have is to unmount the drive ( or remount r/o ) and 
repeatedly md5sum the block device and see if it ever fails to correctly 
read the data, and if you get any errors in your syslog.  If you get no 
error messages in your syslog and md5sum completes without error but 
does not get the same hash each time, then there is definitely something 
very fubar with the hardware or deep in the kernel.

Roy Sigurd Karlsbakk wrote:
> 
> Hi all
> 
> Sorry for stressing this, but is there a way I can debug this further? 
> it's a seagate drive connected to a sata_sil controller. I only get ext3 
> errors, and it fails after a while whatever I do
> 
> thanks
> 
> roy

