Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030378AbWCTV2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbWCTV2j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWCTV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:28:39 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:63939 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030378AbWCTV2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:28:38 -0500
Message-ID: <441F1E75.8050803@oracle.com>
Date: Mon, 20 Mar 2006 13:28:21 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: suparna@in.ibm.com, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>, pbadari@gmail.com
Subject: Re: [patch] bug fix in dio handling write error - v2
References: <200603192227.k2JMRNg30260@unix-os.sc.intel.com>
In-Reply-To: <200603192227.k2JMRNg30260@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Taking one of your earlier idea, how about the following patch: separating
> out IO completion code from partial IO tracking?

I like that, and I think it closes the lost write error hole.  Could we
call it something like io_errno, though?  "completion_code" to me sounds
like -ve errno or +ve bytes read.

I think there are still bugs dealing with errors, but I guess we can
tackle them with seperate patches.

- z
