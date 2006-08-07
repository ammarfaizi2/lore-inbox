Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWHGSVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWHGSVr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWHGSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:21:47 -0400
Received: from smtp-out.google.com ([216.239.45.12]:26693 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932277AbWHGSVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:21:46 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=OFxGonrXfgxO/nhJRVLDSjod7FQb1ShZhMvIzSRtHlnc7nKEIH8JKJEp2mqv37CKh
	vI884gcrZqJfKcRR5eq2A==
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with
	Resource Management - A cpu  controller
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Paul Jackson <pj@sgi.com>
Cc: Kirill Korotaev <dev@sw.ru>, nagar@watson.ibm.com, akpm@osdl.org,
       vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       haveblue@us.ibm.com
In-Reply-To: <20060807101518.aef1f06e.pj@sgi.com>
References: <20060804050753.GD27194@in.ibm.com>
	 <20060803223650.423f2e6a.akpm@osdl.org> <44D35794.2040003@sw.ru>
	 <44D367F3.8060108@watson.ibm.com> <44D6EBEF.9010804@sw.ru>
	 <20060807023025.2c44f3d1.pj@sgi.com> <44D765E3.9040206@sw.ru>
	 <20060807101518.aef1f06e.pj@sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 07 Aug 2006 11:19:58 -0700
Message-Id: <1154974798.31962.30.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 10:15 -0700, Paul Jackson wrote:
> > we have a /proc which is very convenient for use from shell etc. but
> > is not good for applications, not fast enough etc.
> > moreover, /proc had always problems with locking, races and people tend to
> > feel like they can change text presention of data, while applications parsing
> > it tend to break.
> 
> Yes - one can botch a file system API.
> 
> One can botch syscalls, too.  Do you love 'ioctl'?
> 
> For some calls, the performance of a raw syscall is critical.  And
> eventually, filesystem API's must resolve to raw file i/o syscalls.
> 
> But for these sorts of system configuration and management, the
> difference in performance between file system API's and raw syscall
> API's is not one of the decisive issues that determines success or
> failure.
> 
> Getting a decent API that naturally reflects the long term essential
> shape of the data is one of these decisive issues.
> 

Absolutely.  Performance is really not a key here.  Setting-up (or
Tearing down) these  operations shouldn't be that frequent.  Configfs
(or proc) should be able to handle those.


-rohit


