Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266082AbTLIStI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266084AbTLIStI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:49:08 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:17935 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S266082AbTLIStF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:49:05 -0500
Message-ID: <3FD61CA5.6050203@google.com>
Date: Tue, 09 Dec 2003 11:04:05 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
References: <F760B14C9561B941B89469F59BA3A8470255EFB3@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EFB3@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:
> 
> BTW, i386, x86_64 and ia64 all have this macro, so these all might need
> to be looked at.
> 

Yes, it was the differences between the i386 and x86_64 versions that 
made me notice this problem. The ia64 version is in C, so looks safer. 
Ideally there would be a common C definition - the only arch-specific 
part should be the locked cmpxchg, unless this lock is likely to be 
taken/released so often that it's performance critical.

Paul

