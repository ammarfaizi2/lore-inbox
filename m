Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWGYE7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWGYE7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 00:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWGYE7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 00:59:32 -0400
Received: from mga05.intel.com ([192.55.52.89]:10130 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932450AbWGYE7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 00:59:31 -0400
X-IronPort-AV: i="4.07,177,1151910000"; 
   d="scan'208"; a="103498183:sNHT4342611112"
Message-ID: <44C5A529.9060306@linux.intel.com>
Date: Tue, 25 Jul 2006 06:59:21 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: CFQ will be the new default IO scheduler - why?
References: <200607241857.43399.a1426z@gawab.com> <1153758806.3043.55.camel@laptopd505.fenrus.org> <200607250756.49071.a1426z@gawab.com>
In-Reply-To: <200607250756.49071.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Arjan van de Ven wrote:
>>>> Should there be a default scheduler per filesystem?  As some
>>>> filesystems may perform better/worse with one over another?
>>> It's currently perDevice, and should probably be extended to perMount.
>> Hi,
> 
> Hi!
> 
>> per mount is going to be "not funny". I assume the situation you are
>> aiming for is the "3 partitions on a disk, each wants its own elevator".
>> The way the kernel currently works is that IO requests the filesystem
>> does are first flattened into an IO for the entire device (eg the
>> partition mapping is done) and THEN the IO scheduler gets involved to
>> schedule the IO on a per disk basis.
> 
> IC.  That probably explains why concurrent io-procs have such a hard time 
> getting through to the disk.  They probably just hang in the flatting phase, 
> waiting for something to take care of their requests.
> 
flattening is just an addition in the cpu, that's just really boring and shouldn't be visible anywhere
performance wise
