Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbULBIBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbULBIBM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbULBIBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:01:11 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:53391 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S261274AbULBIBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:01:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org>
	<1101837994.2640.67.camel@laptop.fenrus.org>
	<20041130102105.21750596.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 02 Dec 2004 03:01:02 -0500
In-Reply-To: <20041130102105.21750596.akpm@osdl.org>
Message-ID: <yq0eki95dtt.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Arjan van de Ven <arjan@infradead.org> wrote:
>> 
>> On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
>> >
>> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
>> > 
>> > - Various fixes and cleanups
>> > 
>> > - A decent-sized x86_64 update.
>> > 
>> > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect
>> memory > reclaim, but shouldn't.
>> 
>> 
>> what is the purpose of such a zone ??

Andrew> For pages which have a physical address <4G.  I assume this
Andrew> was motivated by the lack of an IOMMU on ia32e?

If we really need such a special case, wouldn't it be about time we
introduced a mask based allocation API instead? There's hardware out
there with 31 bit and 40 bit restrictions.

Doing this solely for the sake of nvidia is certainly questionable.

Regards,
Jes
