Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbSKBXNW>; Sat, 2 Nov 2002 18:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbSKBXNW>; Sat, 2 Nov 2002 18:13:22 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:25085 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261495AbSKBXNV>; Sat, 2 Nov 2002 18:13:21 -0500
Date: Sat, 2 Nov 2002 18:19:52 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jos Hulzink <josh@stack.nl>
Cc: Stas Sergeev <stssppnn@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Larger IO bitmap?
Message-ID: <20021102181952.C2748@redhat.com>
References: <3DC417A4.2000903@yahoo.com> <200211022248.11869.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211022248.11869.josh@stack.nl>; from josh@stack.nl on Sat, Nov 02, 2002 at 10:48:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 10:48:11PM +0100, Jos Hulzink wrote:
> Hi,
> 
> Increasing the IO bitmap size has huge effects on your Task State Segment 
> size. It sure is possible to increase that size, but be aware that this means 
> you are using megabytes for your TSS's only !

Keep in mind that a task's io bitmap is now lazily allocated, so by 
default no memory will be allocated for it.  A similar enhancement 
for large vs small io bitmaps could be made by allowing the task io 
bitmap to be a variable size.

		-ben
