Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVAJOX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVAJOX7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVAJOX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:23:59 -0500
Received: from pat.uio.no ([129.240.130.16]:45478 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262254AbVAJOX5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:23:57 -0500
Subject: Re: make flock_lock_file_wait static
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Arjan van de Ven <arjan@infradead.org>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1105346324.4171.16.camel@laptopd505.fenrus.org>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 10 Jan 2005 09:23:34 -0500
Message-Id: <1105367014.11462.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 10.01.2005 Klokka 09:38 (+0100) skreiv Arjan van de Ven:
>  
> > is "sooner or later" and "maybe someone else uses it" worth making
> > everyone elses kernel bigger by 500 bytes of code ?
> 
> eh 60 not 500; sorry need coffee

It's an API that provides *necessary* functionality for those
filesystems that wish to override the standard flock(). It was very
recently introduced by a third party, so we haven't had time to code up
an NFS flock yet.
Removing it now will just mean that we have to reintroduce it in a month
or so when NFS and the other filesystems start to catch up.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

