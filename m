Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWCPF2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWCPF2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 00:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWCPF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 00:28:53 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:36537 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932370AbWCPF2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 00:28:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5201gTo2NOsqxeeosrm2PlD7r7DuOQGF54x8ydCD72RU6yPqoQnILW+C8GEWypWchJ7JauUNwVpE0IxmlFrn5i2zFZRyuImNkQOmwMOorvyM8XETWES7G3dqzL658nQ1CLmTvBhIgBueLjkX3zObI1SGTtev5bTjBv0I15fugC8=  ;
Message-ID: <4418E879.3000207@yahoo.com.au>
Date: Thu, 16 Mar 2006 15:24:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines for_each_possible_cpu
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>	<4418DEEA.2000008@yahoo.com.au> <20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060316131743.d7b716e9.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Thu, 16 Mar 2006 14:43:38 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>The only places where things might care is arch bootup code, but
>>the cpu interface is such that the arch code is expected to _hide_
>>any weird details from these generic interfaces.
>>
> 
> Please see i386 patch. it contains BUG fix.
> cpu_msrs[i].coutners are allocated by for_each_online_cpu().
> and free it by for_each_possible_cpus() without no pointer check.
> 

Well that's another problem then, such a fix should not be sent in
this patchset, but as a separate patch.

> I think this kind of confusion will be seen again in future.

I'm sure that renaming for_each_cpu would not prevent that either.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
