Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLGSF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGSF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:05:59 -0500
Received: from enigma.barak.net.il ([212.150.48.99]:10239 "EHLO
	enigma.barak.net.il") by vger.kernel.org with ESMTP id S264481AbTLGSFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:05:49 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Creating a page struct for HIGHMEM pages
Date: Sun, 7 Dec 2003 20:05:39 +0200
Organization: Montilio
Message-ID: <00c401c3bcec$bbd52e40$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20031207175915.GZ8039@holomorphy.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I've tried ioremap (and placed the address in the ->virtual field), but
had problems with pre-written code that used kmap.  So, basically, what
you're saying is that I must change my code that uses kmap, or
alternatively, allocated page* below the highmem_start_page address.  Is
this correct?


-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com] 
Sent: Sunday, December 07, 2003 7:59 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating a page struct for HIGHMEM pages


On Sun, Dec 07, 2003 at 07:56:17PM +0200, Amir Hermelin wrote:
> I may be missing something a little more basic: I have a contiguous 
> physical memory area (IO memory), and I want to manage it with struct 
> pages.  If I'm to write to the page I need to kmap it, therefore (as I
understand it) I
> need to zero the ->virtual field.   What I don't understand is how, given
> the struct page I've allocated and filled out, is the page correlated 
> with the correct physical memory.  Where do I put the information that 
> struct page X points to physical address Y, so that when I kmap(X) I 
> get a virtual address pointing to Y?

You probably want ioremap(), not kmap().


-- wli


