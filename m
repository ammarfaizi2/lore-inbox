Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161390AbWJZNvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161390AbWJZNvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 09:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161391AbWJZNvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 09:51:09 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:15748 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161390AbWJZNvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 09:51:08 -0400
Message-Id: <4540D9CF.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 26 Oct 2006 15:52:47 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <vgoyal@in.ibm.com>
Cc: "Andi Kleen" <ak@muc.de>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Ian Campbell" <Ian.Campbell@xensource.com>
Subject: Re: [PATCH] x86_64: Some vmlinux.lds.S cleanups
References: <20061024210140.GB14225@in.ibm.com>
 <45407B05.76E4.0078.0@novell.com> <20061026134442.GA11284@in.ibm.com>
In-Reply-To: <20061026134442.GA11284@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Vivek Goyal <vgoyal@in.ibm.com> 26.10.06 15:44 >>>
>On Thu, Oct 26, 2006 at 08:08:21AM +0100, Jan Beulich wrote:
>> I was about to ack it when I saw that you left .bss in init - that doesn't seem
>> too good an idea... Jan
>> 
>
>Should I create a separate program header say "bss" for .bss section? Last
>time when I suggested it you said there is no need to create a separate
>program header for bss.

No, I continue to think .bss naturally belongs at the end of the data segment.

>More program headers we create, we need to make sure that they are on page
>size boundaries so that kexec on vmlinux does not break.

Jan
