Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVLACfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVLACfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 21:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVLACfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 21:35:54 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:22897 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751361AbVLACfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 21:35:53 -0500
Message-ID: <438E617F.4020005@gmail.com>
Date: Wed, 30 Nov 2005 20:35:43 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
References: <1133377029.27824.90.camel@localhost.localdomain>
In-Reply-To: <1133377029.27824.90.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Badari Pulavarty wrote:
> - How much is just file system cache (regular file data) ?

This is just a thought of mine:
/proc/slabinfo?

> - How much is shared memory pages ?
> - How much is mmaped() stuff ?

cat /proc/vmstat | grep nr_mapped
nr_mapped 77105

But yes, this doesn't give you a detailed account.

> - How much is for text, data, bss, heap, malloc ?

Again, this is just a thought of mine: Couldn't you get this information 
from /proc/<pid>/maps or from the nicer and easier to parse procps 
application: pmap <pid>?

Thanks,

Hareesh
