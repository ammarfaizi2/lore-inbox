Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbUKITXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUKITXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUKITXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:23:51 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50837 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261633AbUKITXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:23:47 -0500
Subject: Re: Externalize SLIT table
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Takayoshi Kochi <t-kochi@bq.jp.nec.com>, steiner@sgi.com,
       linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041104040713.GC21211@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com>
	 <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	 <20041104040713.GC21211@wotan.suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100028224.3980.7.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Nov 2004 11:23:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 20:07, Andi Kleen wrote:
> On Thu, Nov 04, 2004 at 10:59:08AM +0900, Takayoshi Kochi wrote:
> > (3) all distances in one line like /proc/<PID>/stat
> > 
> > % cat /sys/devices/system/node/node0/distance
> > 10 66 46 66
> 
> I would prefer that. 
> 
> -Andi

That would be my vote as well.  One line, space delimited.  Easy to
parse...  Plus you could easily reproduce the entire SLIT matrix by:

cd /sys/devices/system/node/
for i in `ls node*`; do cat $i/distance; done


-Matt

