Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756339AbWKVS1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbWKVS1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756353AbWKVS1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:27:36 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:1463 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756344AbWKVS1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:27:35 -0500
Message-ID: <456424D7.7060204@oracle.com>
Date: Wed, 22 Nov 2006 02:22:15 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@osdl.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH -mm 3/4][AIO] - AIO completion signal notification
References: <20061120151700.4a4f9407@frecb000686>	<20061120152252.7e5a4229@frecb000686>	<4561C60B.5000106@oracle.com> <20061122104055.3d1c029a@frecb000686>
In-Reply-To: <20061122104055.3d1c029a@frecb000686>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   OK, looking at this, there's something bothering me: io_submit_one() needs
> a pointer to the user iocb in order to push back the iocb->ki_key to userspace,
> as well as storing the user_iocb pointer into iocb->ki_obj.

Why can't it continue to do what it does today?  Both of those uses of
the user_iocb pointer involve fixed-width fields and don't need compat help.

>   So I think that some of the logic in io_submit_one() must be moved up to
> sys_io_submit(), including the aio_get_req() call.

I don't see why that would be needed.

- z
