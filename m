Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUAAB2J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUAAB2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 20:28:09 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:58553 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S265316AbUAAB2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 20:28:03 -0500
Message-ID: <3FF377A8.6040302@metaparadigm.com>
Date: Thu, 01 Jan 2004 09:28:08 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: rudi@lambda-computing.de
Cc: ivern@acm.org, linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org> <3FF31A15.4070307@lambda-computing.de>
In-Reply-To: <3FF31A15.4070307@lambda-computing.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/01/04 02:48, Rüdiger Klaehn wrote:
> Javier Fernandez-Ivern wrote:
> 
>> Rüdiger Klaehn wrote:
>>
>>> I have been wondering for some time why there is no decent file 
>>> change notification mechanism in linux. Is there some deep 
>>> philosophical reason for this, or is it just that nobody has found 
>>> the time to implement it? If it is the latter, I am willing to 
>>> implement it as long there is a chance to get this accepted into the 
>>> mainstream kernel.
>>
>>
>>
>> Well, there's fam.  But AFAIK that's all done in user space, and your 
>> approach would be significantly more efficient (as a matter of fact, 
>> fam could be modified to use your change device as a first level of 
>> notification.)
>>
> Fam is a user space library that has some nice features such as network 
> transparent change notification. It currently uses the dnotify mechanism 
> if the underlying kernel supports it, but as I mentioned the dnotify 
> mechanism requires an open file handle and works only for single 
> directories. If the underlying os does not support dnotify, fam resorts 
> to polling for file changes (yuk!).

Have you had a look at dazuko. It provides a consistent file access
notification mechanism (and also intervention for denying access) across
linux and freebsd. It is currently being used by various on-access
virus scanners. It is under active development and supports 2.6 (and 2.4)

http://www.dazuko.org/about.shtml

Seems like a good idea. I've always thought it would be nice to use
something like this to maintain a dynamic locatedb (among many other
potential uses).

~mc

