Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbVHJEsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVHJEsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 00:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbVHJEsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 00:48:31 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:25278 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964954AbVHJEsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 00:48:30 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <42F8E516.7020600@zabbo.net>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: Zach Brown <zab@zabbo.net>, David Teigland <teigland@redhat.com>,
       Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
Date: Wed, 10 Aug 2005 07:48:29 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F9871D.000051DB@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown writes:
> But couldn't we use make_pages_present() to figure which locks we need, 
> sort them, and then grab them?

Doh, obviously we can't as nopage() needs to bring the page in. Sorry about 
that. 

I also thought of another failure case for the vma walk. When a thread uses 
userspace memcpy() between two clusterfs mmap'd regions instead of write() 
or read(). 

              Pekka 
