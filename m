Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752032AbWJZLJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbWJZLJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbWJZLJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:09:28 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:56214 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752136AbWJZLJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:09:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YcBU0SnUzSZfsIXJWYDE/HKFWnRLLKsNqKnmUVDjNWIqxKnC5C988pa8nniA1EfOjlcyG564NM+45ItJT5T9PrlhZnHZY1cPgD95ThqO9af3zt/4W7Hw1xx63Vw0+xxiEDurEpVvm2+1kWgUv1BZHAUdE1jUorhpxFklhzpUe0s=  ;
Message-ID: <45409761.9000806@yahoo.com.au>
Date: Thu, 26 Oct 2006 21:09:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
CC: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061007105758.14024.70048.sendpatchset@linux.site>	 <20061007105853.14024.95383.sendpatchset@linux.site> <21d7e9970610241431j38c59ec5rac17f780813e6f05@mail.gmail.com>
In-Reply-To: <21d7e9970610241431j38c59ec5rac17f780813e6f05@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:
> On 10/7/06, Nick Piggin <npiggin@suse.de> wrote:
> 
>> Nonlinear mappings are (AFAIKS) simply a virtual memory concept that
>> encodes the virtual address -> file offset differently from linear
>> mappings.
>>
> 
> Hi Nick,
> 
> what is the status of this patch? I'm just trying to line up a kernel
> tree for the new DRM memory management code, which really would like
> this...
> 
> Dave.

Hi Dave,

Blocked by another kernel bug at the moment. I hope both fixes can
make it into 2.6.20, but if that doesn't look like it will happen,
then I might try reworking the patchset to break the ->fault change
out by itself because there are several others who would like to use
it as well.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
