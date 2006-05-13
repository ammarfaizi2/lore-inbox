Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWEMMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWEMMvR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWEMMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:51:17 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:62647 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932407AbWEMMvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:51:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SfvgLMor3Dp1IUy9zQelEVfInIzW0mUdqUw4pJMGlfEaAsLCJpS4p4f1bqZ45Gop+2TdTzzCwJn9sFcGJN4kEBHLMWcKuMtJu3fGiRTuM9rvU13fLJ1ZuNOFmTzl72NyssofcE7coQQ18jYimD2CPAjiSaXgBaC5JW4zsKP80Go=  ;
Message-ID: <4465D63F.4000605@yahoo.com.au>
Date: Sat, 13 May 2006 22:51:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
References: <20060509084945.373541000@sous-sol.org>	<20060509085159.285105000@sous-sol.org> <20060513052757.59446e03.akpm@osdl.org>
In-Reply-To: <20060513052757.59446e03.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>+static void kcons_write_dom0(
>>+	struct console *c, const char *s, unsigned int count)
>>+{
>>+	int rc;
>>+
>>+	while ((count > 0) &&
>>+	       ((rc = HYPERVISOR_console_io(
>>+			CONSOLEIO_write, count, (char *)s)) > 0)) {
>>+		count -= rc;
>>+		s += rc;
>>+	}
>>+}
> 
> 
> must.. not.. mention.. coding.. style..

Someone should write you a script to go through a patch and flag the
most common style mistakes. Have the output formatted to look like
you're replying to the mail, and wire it up to your inbox ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
