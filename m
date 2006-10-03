Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWJCSX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWJCSX5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWJCSX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:23:57 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:56336 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S964899AbWJCSX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:23:56 -0400
Message-ID: <4522AAC1.7050703@cfl.rr.com>
Date: Tue, 03 Oct 2006 14:24:01 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Willy Tarreau <w@1wt.eu>, Drew Scott Daniels <ddaniels@UMAlumni.mb.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: Smaller compressed kernel source tarballs?
References: <20061002033511.GB12695@zimmer> <20061002033531.GA5050@1wt.eu> <Pine.LNX.4.61.0610031227420.32633@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0610031227420.32633@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2006 18:24:06.0325 (UTC) FILETIME=[1C657E50:01C6E719]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14728.003
X-TM-AS-Result: No--11.548000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> There are lots of obscure compression formats that achieve somewhat 
> better compression at the cost of MUCH more time (neglecting they are 
> not too open), such as MS CAB and ACE.

CAB is an archive container format, not a compression algorithm.  Last 
time I worked on some code to handle it, they used the standard LZW 
algorithm implemented by gzip ( but had the ability to support others in 
the future ) and could only compress 32kb blocks.  The small block size 
led to poor compression.


