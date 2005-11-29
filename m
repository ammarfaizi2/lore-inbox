Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVK2QrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVK2QrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVK2QrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:47:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932081AbVK2QrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:47:12 -0500
To: vgoyal@in.ibm.com
Cc: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH & RFC] kdump and stack overflows
References: <1133183463.2327.96.camel@localhost.localdomain>
	<m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
	<1133200815.2425.98.camel@localhost.localdomain>
	<m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
	<20051129132730.GA3803@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 29 Nov 2005 09:46:21 -0700
In-Reply-To: <20051129132730.GA3803@in.ibm.com> (Vivek Goyal's message of
 "Tue, 29 Nov 2005 18:57:30 +0530")
Message-ID: <m18xv7fllu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Mon, Nov 28, 2005 at 11:29:29AM -0700, Eric W. Biederman wrote:
>> (baring
>> nmi happening during nmis)  Hmm.  Is there anything to keep
>> us doing something bad in that case?
>> 
>> I guess as long as we don't clear the high bit of port 0x70 we
>> should be reasonably safe from the nmi firing multiple times.
>
> Are you referring to port 0x23 for IMCR register.

No.  Port 0x70 is the cmos address register.  0x71 the cmos
data register.  The high bit of 0x70 if the nmi enable.

Although with local apics generating nmis I would be surprised
if it effective in every case. :)

Eric

