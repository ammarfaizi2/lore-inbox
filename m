Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264470AbTLGSJG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:09:06 -0500
Received: from holomorphy.com ([199.26.172.102]:26585 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264470AbTLGSJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:09:02 -0500
Date: Sun, 7 Dec 2003 10:08:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating a page struct for HIGHMEM pages
Message-ID: <20031207180853.GA8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <20031207175915.GZ8039@holomorphy.com> <00c401c3bcec$bbd52e40$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c401c3bcec$bbd52e40$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 08:05:39PM +0200, Amir Hermelin wrote:
> Yes, I've tried ioremap (and placed the address in the ->virtual field), but
> had problems with pre-written code that used kmap.  So, basically, what
> you're saying is that I must change my code that uses kmap, or
> alternatively, allocated page* below the highmem_start_page address.  Is
> this correct?

You don't need struct pages at all; ioremap() will just map physical to
virtual without the things just fine.


-- wli
