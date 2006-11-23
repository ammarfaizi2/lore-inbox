Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934198AbWKWWfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934198AbWKWWfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 17:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934205AbWKWWfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 17:35:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13487 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934198AbWKWWfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 17:35:44 -0500
Message-ID: <45662206.1070104@redhat.com>
Date: Thu, 23 Nov 2006 14:34:46 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Hans Henrik Happe <hhh@imada.sdu.dk>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
References: <11641265982190@2ka.mipt.ru> <20061123115504.GB20294@2ka.mipt.ru> <4565FDED.2050003@redhat.com> <200611232249.56886.hhh@imada.sdu.dk>
In-Reply-To: <200611232249.56886.hhh@imada.sdu.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Henrik Happe wrote:
> I don't know if this falls under the simplification, but wouldn't there be a 
> race when reading/copying the event data? I guess this could be solved with 
> an extra user index. 

That's what I said, reading the value from the ring buffer structure's 
head would be racy.  All this can only work for single threaded code.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
