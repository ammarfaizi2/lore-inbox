Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWDYVPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWDYVPw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWDYVPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:15:51 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:25612 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751531AbWDYVPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:15:51 -0400
Message-ID: <444E9174.8040909@argo.co.il>
Date: Wed, 26 Apr 2006 00:15:32 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Bongani Hlope <bhlope@mweb.co.za>, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <200604252211.52474.bhlope@mweb.co.za> <444E85E9.70300@argo.co.il> <200604252102.k3PL2iQJ013299@turing-police.cc.vt.edu>
In-Reply-To: <200604252102.k3PL2iQJ013299@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 21:15:46.0384 (UTC) FILETIME=[6B340500:01C668AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Tue, 25 Apr 2006 23:26:17 +0300, Avi Kivity said:
>
> > auto_ptr<>'s are fully inlined so their impact is nil.
>
> Except for the punishment the i-cache takes.  There's reasons why we
> fight over "to inline or not to inline"....
>
Not in this case. The constructor is an assignment. The destructor is an 
if () followed by a delete. In this case, the if () is optimized away so 
you are left with less generated code than the C case, for the 
non-exceptional path.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

