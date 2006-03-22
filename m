Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWCVTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWCVTym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWCVTym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:54:42 -0500
Received: from mail.parknet.jp ([210.171.160.80]:1543 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932424AbWCVTyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:54:41 -0500
X-AuthUser: hirofumi@parknet.jp
To: Avi Kivity <avi@argo.co.il>
Cc: john stultz <johnstul@us.ibm.com>, Con Kolivas <kernel@kolivas.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: gettimeofday order of magnitude slower with pmtimer, which is default
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<20060320145047.GA12332@rhlx01.fht-esslingen.de>
	<200603210224.23540.kernel@kolivas.org>
	<87wteo37vr.fsf@duaron.myhome.or.jp>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp> <4421A18F.4040600@argo.co.il>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Mar 2006 04:54:30 +0900
In-Reply-To: <4421A18F.4040600@argo.co.il> (Avi Kivity's message of "Wed, 22 Mar 2006 21:12:15 +0200")
Message-ID: <87u09ql0g9.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity <avi@argo.co.il> writes:

> OGAWA Hirofumi wrote:
>> Current patch is the following. If I'm missing something, or you have
>> some comment, please tell me. (Since I don't have ICH4, ICH4 detection
>> is untested)
>>   
> Doesn't it make sense to mark the port as user accessible in the I/O 
> permissions bitmap and export it as a vsyscall? that would save the 
> syscall overhead.

Umm.. I don't know. In userland, can we make a stable gettimeofday()
from only PMTMR?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
