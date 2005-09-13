Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbVIMQpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVIMQpl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVIMQpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:45:41 -0400
Received: from fmr16.intel.com ([192.55.52.70]:27087 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S964871AbVIMQpk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:45:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 2.6.13] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Date: Tue, 13 Sep 2005 09:45:21 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F045EB564@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.13] ia64: re-implement dma_get_cache_alignment to avoid EXPORT_SYMBOL
Thread-Index: AcW4XmS7vGgETi1vR124/eLJsDxNXwAI3N8w
From: "Luck, Tony" <tony.luck@intel.com>
To: "Lion Vollnhals" <lion.vollnhals@web.de>,
       "John W. Linville" <linville@tuxdriver.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 13 Sep 2005 16:45:23.0687 (UTC) FILETIME=[8930E770:01C5B882]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  unsigned long ia64_max_cacheline_size;
>> +
>> +int dma_get_cache_alignment(void)
>> +{
>> +        return ia64_max_cacheline_size;
>> +}
>> +EXPORT_SYMBOL(dma_get_cache_alignment);
>> +
>
>Are you intentionally returning an "int" instead of an "unsigned long"?

The old version used to return int, as does the the version
on other architectures.  The problem appears to be the
definition "unsigned long ia64_max_cacheline_size;"

I think an int should be plenty big enough :-)

-Tony
