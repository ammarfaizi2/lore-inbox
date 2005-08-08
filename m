Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVHHXPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVHHXPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVHHXPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:15:22 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:14021 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932350AbVHHXPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:15:21 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: Tom Rini <trini@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] x86_64: Rename KDB_VECTOR to DEBUGGER_VECTOR 
In-reply-to: Your message of "Mon, 08 Aug 2005 21:28:50 +0200."
             <20050808192850.GQ19170@wotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Aug 2005 09:14:52 +1000
Message-ID: <19345.1123542892@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005 21:28:50 +0200, 
Andi Kleen <ak@suse.de> wrote:
>On Mon, Aug 08, 2005 at 12:27:10PM -0700, Tom Rini wrote:
>>  {
>>  	unsigned int icr =  APIC_DM_FIXED | shortcut | vector | dest;
>> -	if (vector == KDB_VECTOR)
>> +	if (vector == NMI_VECTOR)
>>  		icr = (icr & (~APIC_VECTOR_MASK)) | APIC_DM_NMI;
>
>That if () should be removed since it's useless.
>Can you do that please?

Why is 'if ()' useless?  Remove the if test and all ipis get sent as
NMI, we definitely do not want that.

