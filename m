Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271391AbTG2LM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbTG2LMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:12:18 -0400
Received: from gate.corvil.net ([213.94.219.177]:43782 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S271394AbTG2LKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:10:53 -0400
Message-ID: <3F265630.1080503@draigBrady.com>
Date: Tue, 29 Jul 2003 12:10:40 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balram Adlakha <b_adlakha@softhome.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 NFS file transfer
References: <20030728225947.GA1694@localhost.localdomain> <20030729014822.6488539d.akpm@osdl.org> <20030729105706.GA2761@localhost.localdomain>
In-Reply-To: <20030729105706.GA2761@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balram Adlakha wrote:
> On Tue, Jul 29, 2003 at 01:48:22AM -0700, Andrew Morton wrote:
> 
>>Balram Adlakha <b_adlakha@softhome.net> wrote:
>>
>>>I cannot transfer files larger than 914 mb from an NFS mounted
>>>filesystem to a local filesystem. A larger file than that is
>>>simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
>>>works fine.

Looks like rounding around 32 bits to me:

$ echo "((2^32)+(914*(1024^2)))/(1024^3)" | bc -l
4.89 #GB

Pádraig.

