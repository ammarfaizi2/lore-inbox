Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVAJXuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVAJXuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVAJXuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:50:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:62657 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262738AbVAJXeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:34:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=aV1cREwN8kAQgfrGv4W07ggojjUK/gYQ3QK8Gbzv8zuwFTyGvTYHOpEiV/o2YnCX1nVRBlqrymBb3JE/j61KAhH5uLSKTJQuMz+p1PRtHsKGJZ4jOHtd11nqUfctJy6/vk0MUcNM1O+N60mXvLFDqKdBa4jWikJgfeJRXFqsUMY=
Message-ID: <8746466a050110153479954fd2@mail.gmail.com>
Date: Mon, 10 Jan 2005 16:34:03 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: clean way to support >32bit addr on 32bit CPU
Cc: torvalds@osdl.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this ARM (XScale) based platform that supports 36bit physical
addressing. Due to the way the ATU is designed, the outbound memory
translation window is fixed outside the first 4GB of memory space, and
thus the need to use 64bit addressing in order to access the PCI bus. 
After all said and done, the struct resource members start and end
must support 64bit integer values in order to work. On a 64bit arch
that would be fine since unsigned long is 64bit. However on a 32bit
arch one must use unsigned long long to get 64bit. However, if we do
that then it would make the 64bit archs to have 128bit start and end
and probably wouldn't be something we'd want. What would be a nice
clean way to support this that's acceptable to Linux? I guess this
issue would be similar to x86-32 PAE would have?

Also, please cc me on on the discussion. Not sure if my LKML
subscription is working... Thanks!

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel dot com
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
