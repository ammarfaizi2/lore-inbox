Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263927AbRGEVZh>; Thu, 5 Jul 2001 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263933AbRGEVZ1>; Thu, 5 Jul 2001 17:25:27 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:33284 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S263927AbRGEVZR>;
	Thu, 5 Jul 2001 17:25:17 -0400
To: hunghochak@netscape.net (Ho Chak Hung)
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <6586AA62.338A01A4.0F76C228@netscape.net>
From: Jes Sorensen <jes@sunsite.dk>
Date: 05 Jul 2001 23:25:10 +0200
In-Reply-To: hunghochak@netscape.net's message of "Mon, 02 Jul 2001 12:59:52 -0400"
Message-ID: <d3lmm3vzk9.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ho" == Ho Chak Hung <hunghochak@netscape.net> writes:

Ho> Hi, I got the error __alloc_pages: 4-order allocation failed in a
Ho> module that uses and frees a lot of pages.  Basically, I am trying
Ho> implement a page cache for the module. First, I keep allocating
Ho> pages using page_cache_alloc() until it fails, then I free a whole
Ho> bunch of pages using freepages((unsigned long)page_address(page))

Ho> Would anyone please give me some advice about how to solve this
Ho> problem?  Thanks a lot.

You ran out of memory, ie. there were no more free blocks of 16
consecutive pages available in the system. This is what happens on a
system with little memory or which is loaded with memory intensive
applications.

Jes
