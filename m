Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVDFV3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVDFV3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVDFV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:29:20 -0400
Received: from pat.uio.no ([129.240.130.16]:26355 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262336AbVDFV3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:29:05 -0400
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make
	sense
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050406160123.GH347@unthought.net>
References: <20050406160123.GH347@unthought.net>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 17:28:56 -0400
Message-Id: <1112822936.13304.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.802, required 12,
	autolearn=disabled, AWL 1.20, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 06.04.2005 Klokka 18:01 (+0200) skreiv Jakob Oestergaard:
> What do I do?
> 
> Performance sucks and the profiles do not make sense...
> 
> Any suggestions would be greatly appreciated,

A look at "nfsstat" might help, as might "netstat -s".

In particular, I suggest looking at the "retrans" counter in nfsstat.

When you say that TCP did not help, please note that if retrans is high,
then using TCP with a large value for timeo (for instance -otimeo=600)
is a good idea. It is IMHO a bug for the "mount" program to be setting
default timeout values of less than 30 seconds when using TCP.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

