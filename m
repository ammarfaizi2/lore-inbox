Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWJYRwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWJYRwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161295AbWJYRwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:52:17 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:14268 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1161254AbWJYRwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:52:16 -0400
Message-ID: <453FA220.3090001@wolfmountaingroup.com>
Date: Wed, 25 Oct 2006 11:42:56 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Nate Diller <nate.diller@gmail.com>, sds@tycho.nsa.gov, jmorris@namei.org,
       chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Security issues with local filesystem caching
References: <453F9555.1050201@wolfmountaingroup.com>  <16969.1161771256@redhat.com> <5c49b0ed0610250952i2fcc64b7t47fb7565cada14c6@mail.gmail.com> <25083.1161796876@redhat.com>
In-Reply-To: <25083.1161796876@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

>Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:
>
>  
>
>>SELinux support addresses all of these issues for B1 level security quite
>>well with mandatory access controls at the fs layers.  In fact, it works so
>>well, when enabled you cannot even run apache on top of an FS unless
>>configured properly.
>>    
>>
>
>How?  The problem I've got is that the caching code would be creating and
>accessing files and directories with the wrong security context - that of the
>calling process - and not a context suitable for sharing things in the cache
>whilst protecting them from userspace as best we can.
>  
>
Have it access them as 0.0 (root) when you change the fsuid, etc. and I 
think this would satisfy security concerns.  I agree that it sounds like
someone needs to instrument MAC layers with this subsystem.

Jeff

>David
>
>  
>

