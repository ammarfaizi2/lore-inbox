Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261845AbUJYOok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbUJYOok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUJYOoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:44:34 -0400
Received: from pat.uio.no ([129.240.130.16]:51197 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261838AbUJYOlS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:41:18 -0400
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 25 Oct 2004 10:41:11 -0400
Message-Id: <1098715271.10720.37.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 25.10.2004 Klokka 17:02 (+0300) skreiv Denis Vlasenko:

> I am using NFS root. At shutdown, when I kill
> all processes with killall5 -9, NFS temporarily
> misbehaves. I narrowed it down to rpciod feeling
> bad when signalled with SIGKILL:

That is a deliberate feature. It is useful when mountpoints hang etc.

Note however that the patches that convert rpciod to use a workqueue
(they can be found in the latest -mm kernels) remove this feature.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

