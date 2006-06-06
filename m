Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWFFU6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWFFU6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWFFU6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:58:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:59723 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWFFU6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:58:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eihp05sXZZDwnNX3zrJgN68xL5NFQgSFN1p+VmmAch1lJl+S/xKGGAp6KTtexhmIxMXCCjhDHwz+f9Zq48HjpUSyBRUgxZXwfWNB5RbEYEE3LsWL41ueWAtNPI/ku2/wUW3R5+8MUpv+MFpRd8PbUnAaRKEmu2Rkt8axf9pz6/c=
Message-ID: <4ae3c140606061358j140eec9fl45e22f8a9e673215@mail.gmail.com>
Date: Tue, 6 Jun 2006 16:58:13 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Linux SLAB allocator issue
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to check how many slabs are used for inode_cache, but
found that all slabs are added to slabs_full list, and slabs_partial
is always empty. Even if the active object number does not exactly
occupy all slabs.

Does that mean Linux 2.6 remove the use of slabs_partial?

Another question, the constructor transfered to the
kmem_cache_create() function is called for every object in a slab when
it is created. Is this true? Is there any way to call back a function
_only once_ when a new slab is allocated?

Thanks,
Xin
