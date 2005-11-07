Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVKGAEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVKGAEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 19:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVKGAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 19:04:46 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:45836 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932375AbVKGAEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 19:04:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:references:content-type:mime-version:content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=fvt09nLz+FmkXDE0IvdKCR/fwoOASWKIFGL3kknHMitzPftHErGU6p1pU48WQvUpZ7q3q7A3fp/isivDjjfNnLhl11IymBjbkA/8lmx/87i02Uca16sSrhktq9ymMMpGyTATl32r2FE3CqGPiqW3QONHZJhlFVnvYdRve1nvqxA=
Date: Mon, 07 Nov 2005 03:05:55 +0300
From: unDEFER <undefer@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: FileSystem, "." and "..", rmdir
References: <op.sztqupcjty9wl4@undecomp>
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.szufv5uyty9wl4@undecomp>
In-Reply-To: <op.sztqupcjty9wl4@undecomp>
User-Agent: Opera M2/8.50 (Linux, build 1358)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В письме от Sun, 06 Nov 2005 18:05:03 +0300, unDEFER <undefer@gmail.com> сообщал:

> So anything call "delete_inode" for directory and it's entries but it is not empty! What is? Why? What I could made not so?

Oh! I found my big error! It is here (in struct super_operations):
.drop_inode     = generic_delete_inode,

So, second problem is solved.

-- 
Nikolaj Krivchenkov aka unDEFER
registered Linux user #360474
Don't worry, I can read OpenOffice.org
