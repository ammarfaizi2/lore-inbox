Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWBIIfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWBIIfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBIIfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:35:08 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:33133 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750798AbWBIIfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:35:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VcMjPbpNXiFJKAYpc2WwSE9gZAI4THePO2tFv/FUzX3zfLFLRAH5jmMac5ObjlmtrJ4SN+wmJx8R+TCRAWC7MARfm0B3SQdBjhuta9YOxyWzjdtbxEEh1H9C528or06IXZDpNSOkSUbHIYNn1zXQF50KNY67zGTAjt3WZpj8UPE=  ;
Message-ID: <43EAFEB9.2060000@yahoo.com.au>
Date: Thu, 09 Feb 2006 19:35:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com> <20060209001850.18ca135f.akpm@osdl.org>
In-Reply-To: <20060209001850.18ca135f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> 2.4:
> 
> 	MS_ASYNC: dirty the pagecache pages, start I/O
> 	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O
> 
> 2.6:
> 
> 	MS_ASYNC: dirty the pagecache pages
> 	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O.
> 
> So you're saying that doing the I/O in that 25-100msec window allowed your
> app to do more pipelining.
> 
> I think for most scenarios, what we have in 2.6 is better: it gives the app
> more control over when the I/O should be started. 

How so?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
