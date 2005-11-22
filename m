Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbVKVUV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbVKVUV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVKVUV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:21:28 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:37509 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965170AbVKVUV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:21:27 -0500
Subject: Re: mmap64() behaviour on 64-bit machines ?
From: Nicholas Miell <nmiell@comcast.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132677293.24066.242.camel@localhost.localdomain>
References: <1132677293.24066.242.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 12:21:21 -0800
Message-Id: <1132690881.2854.6.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 08:34 -0800, Badari Pulavarty wrote:
> Hi,
> 
> I am confused on the behaviour of mmap64() on 64-bit machines.
> When I run following simple program, I get SIGSEGV in memset().
> But if I replace mmap64() with mmap() - it works fine.
> I verified this on ppc64, em64t, amd64.
> 
> Whats happening here ? Any clues ?

If I fix all the compiler warnings, it works for me.

Also, mmap/mmap64 return MAP_FAILED on failure, not 0, but the compiler
doesn't know to warn about that.

-- 
Nicholas Miell <nmiell@comcast.net>

