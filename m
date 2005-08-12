Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVHLGli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVHLGli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVHLGli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:41:38 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:1356 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1750835AbVHLGlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:41:37 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.96,102,1122847200"; 
   d="scan'208"; a="13971772:sNHT26934108"
Message-ID: <42FC448F.6070702@fujitsu-siemens.com>
Date: Fri, 12 Aug 2005 08:41:19 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: files_lock deadlock?
References: <42DD2E37.3080204@fujitsu-siemens.com>	 <1121870871.1103.14.camel@localhost.localdomain>	 <42FB8ECF.4090106@fujitsu-siemens.com> <1123782699.3201.43.camel@laptopd505.fenrus.org>
In-Reply-To: <1123782699.3201.43.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> I disagree, it's a performance cost.
> It's a lot easier to make remove_proc_entry() a might_sleep().. (I'm
> surprised it isn't already btw given that it's vfs related and the vfs
> is mostly semaphore based)

Well enough. But to my understanding using spin_lock implies that we can 
_prove_ the lock won't be taken in softirq context, and that we will be 
able to prevent new such paths to be introduced in the future. I wonder 
if that's possible for this lock.

Regards,
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
