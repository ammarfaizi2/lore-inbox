Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTLGR72 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGR72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:59:28 -0500
Received: from holomorphy.com ([199.26.172.102]:25305 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264467AbTLGR70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:59:26 -0500
Date: Sun, 7 Dec 2003 09:59:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating a page struct for HIGHMEM pages
Message-ID: <20031207175915.GZ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <20031207162203.GQ19856@holomorphy.com> <00ac01c3bceb$757b30d0$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ac01c3bceb$757b30d0$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 07:56:17PM +0200, Amir Hermelin wrote:
> I may be missing something a little more basic: I have a contiguous physical
> memory area (IO memory), and I want to manage it with struct pages.  If I'm
> to write to the page I need to kmap it, therefore (as I understand it) I
> need to zero the ->virtual field.   What I don't understand is how, given
> the struct page I've allocated and filled out, is the page correlated with
> the correct physical memory.  Where do I put the information that struct
> page X points to physical address Y, so that when I kmap(X) I get a virtual
> address pointing to Y?

You probably want ioremap(), not kmap().


-- wli
