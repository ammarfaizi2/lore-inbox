Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTJFOuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbTJFOuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:50:39 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:57546 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262276AbTJFOui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:50:38 -0400
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF79F7FC5D.894CD912-ONC1256DB7.0051545B-C1256DB7.00516DD4@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 16:49:25 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 16:49:57
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Just checked. You right about chp_release which should do
> > a kfree on the struct channel_path object. But the two
> > other release functions are really dummy functions because
> > cu3088_root_dev and iucv_root are static structures.
>
> Even in that case you're screwed in case they are in modules..

Why? The root device are registered in the module init function
and unregistered in the module exit function. I fail to see the
problem.

blue skies,
   Martin


