Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTLKGMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 01:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTLKGMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 01:12:15 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:7853 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264364AbTLKGMM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 01:12:12 -0500
Message-ID: <3FD80AB7.3010909@cyberone.com.au>
Date: Thu, 11 Dec 2003 17:12:07 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Raul Miller <moth@magenta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <20031211010132.F28449@links.magenta.com>
In-Reply-To: <20031211010132.F28449@links.magenta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Raul Miller wrote:

>On Wed, Dec 10, 2003 at 11:06:46PM -0600, Donald Maner wrote:
>
>>The kernel you're using WAS compiled with CONFIG_HIGHMEM4G=y, correct?
>>
>
>No.
>
>
>On Thu, Dec 11, 2003 at 04:13:25PM +1100, Nick Piggin wrote:
>
>>Or ARCH=x86_64 ?
>>
>
>Yes.  Well, no... I don't see that option in my .config.  I
>did specify the amd64 bit archictecture, but I don't know
>what that means in .config terms.  Here's what's set under
>"# Processor type and features":
>

This optimises the kernel for your chip when its in 32-bit mode.
make 'ARCH=x64_64' to make a 64-bit kernel, however you would
need a cross compiler.

>
>On Thu, Dec 11, 2003 at 04:48:51PM +1100, Nick Piggin wrote:
>
>>At any rate, Raul, highmem shouldn't hurt your performance significantly
>>with the 2.6 kernel. If it does then send a note to the list.
>>
>
>Ok, I guess I'll try that (tomorrow, unless I hear any better suggestions
>before then).
>
>[I thought highmem was something completely different -- that it declared
>a watermark and memory above that watermark was treated differently.
>However, I guess I understand that this might have the side effect of
>bumping things around such that I get access to the memory.]
>

No you're right, but the kernel tries not to use highmem for data it
accesses a lot. cache and anonymous memory for example.


