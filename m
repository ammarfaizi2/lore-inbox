Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUFLGcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUFLGcD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 02:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUFLGcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 02:32:03 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:26216 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264652AbUFLGcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 02:32:00 -0400
Message-ID: <40CAA358.9070603@yahoo.com.au>
Date: Sat, 12 Jun 2004 16:31:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Guy Van Sanden <n.b@myrealbox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Heavy iowait on 2.6 kernels
References: <1086942905.10540.69.camel@cronos.home.vsb>
In-Reply-To: <1086942905.10540.69.camel@cronos.home.vsb>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guy Van Sanden wrote:
> I recently discovered why my new Gentoo server slows to a crawl on a
> intermediate load on the 2.6 kernel series.  The reason seems to be an
> unusual amount of iowait.
> I can reproduce this on two systems, one with a KT400 and and one with
> Sis735 chipset.
> 
> iostat -c 1 (or vmstat) while running something like bonnie produces
> iowaits of 99%.
> Any 2.6 kernel responds the same (regardless of the patchset), even
> vanilla. (2.6.5-mm, 2.6.6-mm, 2.6.6-vanilla and 2.6.5-gentoo-r1).
> Any 2.4-series kernel is fine.
> 

Hi, can you try booting with elevator=deadline, please?
Then include a vmstat 1 output for a 2.6 and a 2.4 kernel.

I don't think 2.4 kernels will show iowait, so some real
performance measurements would be helpful.

Thanks

