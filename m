Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVG3A0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVG3A0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVG3AYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:24:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60044 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262761AbVG3AXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:23:03 -0400
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4: no hyperthreading and idr_remove() stack traces
References: <20050729162006.GA18866@janus>
	<20050729170319.23f24a01.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 18:22:47 -0600
In-Reply-To: <20050729170319.23f24a01.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 29 Jul 2005 17:03:19 -0700")
Message-ID: <m17jf9gn1k.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Frank van Maarseveen <frankvm@frankvm.com> wrote:
>>
>> 2.6.13-rc4 does not recognize the second CPU of a 3GHz HT P4:
>
> OK, we seem to have broken your APIC code.

There is a big difference here in that one kernel is using
the ACPI MADT tables and the other kernel is using the MP table.

I suspect the MP table on your system is incomplete while 
your ACPI MADT does specify both logical cpus. 

Eric
