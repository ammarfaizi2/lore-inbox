Return-Path: <linux-kernel-owner+w=401wt.eu-S933028AbWLaGDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbWLaGDM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 01:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWLaGDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 01:03:12 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:30836 "HELO
	smtp109.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S933028AbWLaGDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 01:03:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lL/93qnaRrvgLUAyROZ7Sbu/PnvY6J8n1KeHmGle174YtuwtXCj28fYNZzGiR3mzP9O7qXRBg9T4gVm1nl4v3kfcnWHGgNU6RkcX8B4z0uUkcqEl8t3QPH1jqWGfC2LqDKvts7wtWpfnUQ5wxGro9NXE1firUQQAXNVCGjw4z4s=  ;
X-YMail-OSG: fDxm7m0VM1kybZfMyK_LIcVq60pC4tsyOz1fX9T_7481dFvGR3.SHcDtD5JToEEZCoexRN_.Wd.JGciCiP9vNvcVcVqRMeT8I_AiAFaOx8dv3N9antx4I0bQ79jnPS537Fz0nG80DvqthjU-
Message-ID: <45975274.6020909@yahoo.com.au>
Date: Sun, 31 Dec 2006 17:02:28 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Aubrey <aubreylee@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Page alignment issue
References: <6d6a94c50612270749j77cd53a9mba6280e4129d9d5a@mail.gmail.com>
In-Reply-To: <6d6a94c50612270749j77cd53a9mba6280e4129d9d5a@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey wrote:
> As for the buddy system, much of docs mention the physical address of
> the first page frame of a block should be a multiple of the group
> size. For example, the initial address of a 16-page-frame block should
> be 16-page aligned. I happened to encounted an issue that the physical
> addresss pf the block is not 4-page aligned(0x36c9000) while the order
> of the block is 2. I want to know what out of buddy algorithm depend
> on this feature?

I think that's correct. The buddy allocator uses bitwise operations to
find buddy pages and promote free pairs (eg. see __page_find_buddy()
and __find_combined_index()).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
