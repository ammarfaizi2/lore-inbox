Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTDJPNX (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTDJPNX (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 11:13:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:38871 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264066AbTDJPNW (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 11:13:22 -0400
Date: Thu, 10 Apr 2003 08:24:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix obj vma sorting
Message-ID: <212430000.1049988260@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0304101618570.1873-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304101618570.1873-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Eeek. There's no way we can set this up to do it as two separate VMAs
>> initially, is there?
> 
> What if we could?  It's already shown the VMA sorting is (liable to be)
> too slow.  Changing that most common case won't change the fact.

Well, it'd thrash it substantially less, I guess. However, you're probably
right ... need a design change instead of tweaking. Doubling the number
of tasks would probably just take us back to where we were before ... need
something more radical.

M.

