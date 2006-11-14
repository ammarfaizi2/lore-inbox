Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966387AbWKNVk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966387AbWKNVk5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966385AbWKNVk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:40:56 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58248 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S966386AbWKNVkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:40:55 -0500
Message-ID: <455A37B6.2020409@zytor.com>
Date: Tue, 14 Nov 2006 13:40:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Pavel Machek <pavel@suse.cz>, Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
References: <20061113162135.GA17429@in.ibm.com>	<20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz> <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
>> Why is PGE no longer required, for example?
> 
> PGE is never required.  Especially on a temporary page table.
> PGE is an optimization, to make context switches faster.
> 

You cannot, however, set the Global bit unless PGE is supported by the 
CPU (you'll trap.)

	-hpa
