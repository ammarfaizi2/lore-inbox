Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTDMTuJ (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 15:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbTDMTuJ (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 15:50:09 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:13907 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261808AbTDMTuI (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 15:50:08 -0400
Message-ID: <3E99C001.7030209@myrealbox.com>
Date: Sun, 13 Apr 2003 12:52:33 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67: ppa driver & preempt == oops
References: <fa.e0puan3.1f34a3p@ifi.uio.no> <fa.h6rb9ej.ml8qhn@ifi.uio.no>
In-Reply-To: <fa.h6rb9ej.ml8qhn@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Gert Vervoort <gert.vervoort@hccnet.nl> wrote:
> 
>>ppa: Version 2.07 (for Linux 2.4.x)
>>ppa: Found device at ID 6, Attempting to use EPP 16 bit
>>ppa: Communication established with ID 6 using EPP 16 bit
>>scsi0 : Iomega VPI0 (ppa) interface
>>bad: scheduling while atomic!
> 
> 
> This patch should make the warnings go away.
> 
> I've been sitting on it for a while, waiting for someone to tell me if the
> ppa driver actually works.  Perhaps that person is you?

I've responded to your questions more than once but evidently you
haven't seen or been able to parse my responses.

To recap:  I see a non-fatal kernel-oops and modprobe segfaults after
successfully loading the ppa module.  Once the ppa module is loaded the
ppa driver actually does work with 2.5.x for at least x>50 (I haven't 
tried x<50).

I am using preemptable kernel and devfs and I do NOT see any of the
warnings that Geert is seeing.  The only problems I see with Linus's
2.5.x kernels is the segfault by modprobe, not with the function of
ppa itself.

What definitely confused me for a long time is that the -ac series
doesn't work with devfs+ppa because the scsi ppa device never
shows up in /dev -- but I think that has nothing to do with Geert's
problem or with your question either, just an aside to explain why
my previous posts may have been confusing the issue.

BTW, the parallel Zip drive is the only SCSI device I have.  Would
my kernel config file be of any use to you?

