Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbTJFOlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTJFOlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:41:25 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:41717 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S262201AbTJFOlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:41:24 -0400
Subject: Re: [PATCH] s390 (2/7): common i/o layer.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF0C1219E4.69DD3439-ONC1256DB7.004E702C-C1256DB7.00509377@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 16:40:06 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 16:40:39
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christoph,

> Eek.  How is the dummy release function supposed to help
> anything?  you must free the object in ->release.  Also
> the assignment is horrible as hell.

Just checked. You right about chp_release which should do
a kfree on the struct channel_path object. But the two
other release functions are really dummy functions because
cu3088_root_dev and iucv_root are static structures.
I'll ask Conny about the her chsc.c code.

blue skies,
   Martin

P.S. whats wrong with the struct assignments ?

