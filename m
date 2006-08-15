Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWHOSle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWHOSle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbWHOSle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:41:34 -0400
Received: from main.gmane.org ([80.91.229.2]:43742 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965066AbWHOSld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:41:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: Strange write starvation on 2.6.17 (and other) kernels
Date: Tue, 15 Aug 2006 18:40:41 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <ebt4f9$sri$1@sea.gmane.org>
References: <44E0A69C.5030103@agh.edu.pl>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: jameson.reflexsecurity.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

szymans@agh.edu.pl said:
> I've encountered a strange problem - if an application is sequentially 
> writing a large file on a busy machine, a single write() of 64KB may 
> take even 30 seconds. But if I do fsync() after each write() the maximum 

If the sleeps are that long, and reproducible, then maybe you can find
the offending wait by using sysrq-t while the writer is blocked.

Jason

