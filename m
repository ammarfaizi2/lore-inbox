Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265021AbTIDOVA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTIDOVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:21:00 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12447 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265021AbTIDOU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:20:58 -0400
Message-ID: <3F574A49.7040900@namesys.com>
Date: Thu, 04 Sep 2003 18:20:57 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ReiserFS <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: precise characterization of ext3 atomicity
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it correct to say of ext3 that it guarantees and only guarantees 
atomicity of writes that do not cross page boundaries?

I am trying to define the difference between "Atomic Reiser4" and ext3, 
as it seems to be a frequently asked question, and I am thinking of 
saying something like:

    Reiser4 allows you to define a set of up to A separate arbitrary 
filesystem operations (where A by default is not allowed to exceed 64) 
that are to be committed to disk atomically.  Every individual 
filesystem operation is atomic without the need to specify it.

    By contrast, ext3 only guarantees the atomicity of a single write 
that does not span a page boundary, and it guarantees that its internal 
metadata will not be corrupted even if your applications data is 
corrupted after the crash.

-- 
Hans


