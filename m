Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031238AbWKVKKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031238AbWKVKKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031133AbWKVKKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:10:40 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:12306 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1031238AbWKVKKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:10:39 -0500
Message-ID: <45642430.6030009@sw.ru>
Date: Wed, 22 Nov 2006 13:19:28 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, devel@openvz.org
Subject: Re: [SPARC64]: resumable error decoding
References: <45630257.9070308@openvz.org> <20061121.161158.63124759.davem@davemloft.net>
In-Reply-To: <20061121.161158.63124759.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Running stress tests on OpenVZ 2.6.18 sparc64 kernel we hit the following:
>>------- cut --------
>>[285401.094964] RESUMABLE ERROR: Reporting on cpu 0
>>[285401.626736] RESUMABLE ERROR: err_handle[410000000000c6f] err_stick[103921ee2007c] err_type[00000004:warning resumable]
>>[285402.869015] RESUMABLE ERROR: err_attrs[00000020:       ]
>>[285403.491920] RESUMABLE ERROR: err_raddr[0000000000000000] err_size[0] err_cpu[0]
> 
> 
> This is a power-off request, did someone push the power-off button
> or give the power-off command from the System Controller console?
ahh, looks like this :)
one of our users reproduced an issue which causes both mainstream and
2.6.18 OVZ kerenls to hang on sparc :/ will investigate...
probably he reset the box after the hang :)

> I should add proper support for this, this report is a good reminder
> :-)
would be nice :@)

> All resumable errors of type 0x4 are power-off requests.
> Unfortunately these encodings are not in any of the publicly published
> documents.
thanks a lot for the explanation!

Thanks,
Kirill

