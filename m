Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUHFWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUHFWyt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUHFWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 18:54:49 -0400
Received: from hera.kernel.org ([63.209.29.2]:23720 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266189AbUHFWys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 18:54:48 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: PATCH: fix some 32bit isms
Date: Fri, 6 Aug 2004 22:53:50 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <cf125u$hnt$1@terminus.zytor.com>
References: <20040728135941.GA17409@devserv.devel.redhat.com> <20040728092334.74e0cfcd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1091832830 18174 127.0.0.1 (6 Aug 2004 22:53:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 6 Aug 2004 22:53:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040728092334.74e0cfcd.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
>
> Alan Cox <alan@redhat.com> wrote:
> >
> >  		printk(MYIOC_s_ERR_FMT 
> >   		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
> >  -		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
> >  +		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,
> 
> printk expects %zd for a size_t
> 

It should be %zu, since size_t is unsigned.

%zd is appropriate for ssize_t.

	-hpa
