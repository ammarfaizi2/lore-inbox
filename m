Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275767AbRJBCBr>; Mon, 1 Oct 2001 22:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275758AbRJBCBh>; Mon, 1 Oct 2001 22:01:37 -0400
Received: from zok.SGI.COM ([204.94.215.101]:49624 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S275760AbRJBCBT>;
	Mon, 1 Oct 2001 22:01:19 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Rinaldi J. Montessi" <rinaldij@adelphia.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC revisited 
In-Reply-To: Your message of "Mon, 01 Oct 2001 18:56:16 -0400."
             <3BB8F490.4638A81E@adelphia.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 02 Oct 2001 12:01:33 +1000
Message-ID: <14109.1001988093@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Oct 2001 18:56:16 -0400, 
"Rinaldi J. Montessi" <rinaldij@adelphia.net> wrote:
>I am of the impression that with the noapic parameter all calls are to
>be handled via CPU0, yet I am getting several errors on CPU1 as well. 

noapic only affects external internal interrupts.  Inter processor
interrupts (IPIs) always use the APIC bus.  Ix86 SMP does a lot of
IPIs.

