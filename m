Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVGDNmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVGDNmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVGDNmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:42:37 -0400
Received: from relay03.pair.com ([209.68.5.17]:20233 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261715AbVGDNUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:20:50 -0400
X-pair-Authenticated: 24.126.76.52
Message-ID: <42C935B7.1050506@kegel.com>
Date: Mon, 04 Jul 2005 06:12:23 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible;MSIE 5.5; Windows 98)
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Will Cohen <wcohen@redhat.com>, Brandan C Lennox <brandan@bclennox.com>
Subject: re: function ordering (was: Re: [RFC] exit_thread() speedups in x86
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> hmm. I wonder if a slightly different approach (based on the __slow)
> idea would make sense
> 1) Use -ffunction-sections option from gcc to put each function in it's
> own section
> 2) Use readprofile/oprofile data to collect an (external to the code)
> list of hot/cold functions (we can put a default list in the kernel
> source somewhere and allow people to measure their own if they want)
> 3) Use this list to make a linker script to order the functions

Somebody recently implemented something similar; see
http://www.bclennox.com/ldreorder/
It used valgrind rather than oprofile.
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
