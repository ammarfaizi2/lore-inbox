Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753458AbWKFRE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbWKFRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbWKFRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:04:27 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:10233 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1753458AbWKFRE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:04:26 -0500
Message-ID: <454F6B19.8010701@cfl.rr.com>
Date: Mon, 06 Nov 2006 12:04:25 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Brent Baccala <cosine@freesoft.org>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org> <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org> <20061106104350.G <20061106160250.GY13555@kernel.dk>
In-Reply-To: <20061106160250.GY13555@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2006 17:04:36.0500 (UTC) FILETIME=[A3677540:01C701C5]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14796.003
X-TM-AS-Result: No--9.443300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> You could optimistically retry when you had reaped some completed
> events, or use some controlled way of blocking for free request
> notification. There are many ways, most of them share the fact that the
> time between notification and new io_submit() may change the picture, in
> which case you'd get EAGAIN once more.
> 
> The important bit is imho to make the blocking at least deterministic.
> At some point you _have_ to block for resources, but it's not very
> polite to be blocking for a considerable time indeterministically.
> 

Right, but there currently exists no mechanism for waiting until there 
is room in the queue is there?  My point was that this would be required 
in order to return EAGAIN.

