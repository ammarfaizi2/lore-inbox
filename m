Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281455AbRKMDUp>; Mon, 12 Nov 2001 22:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281457AbRKMDUg>; Mon, 12 Nov 2001 22:20:36 -0500
Received: from rj.sgi.com ([204.94.215.100]:48861 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281455AbRKMDU0>;
	Mon, 12 Nov 2001 22:20:26 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Changed message for GPLONLY symbols 
In-Reply-To: Your message of "Mon, 12 Nov 2001 20:01:19 PDT."
             <200111130301.fAD31JJ15767@vindaloo.ras.ucalgary.ca> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 14:20:15 +1100
Message-ID: <10870.1005621615@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001 20:01:19 -0700, 
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:
>How about actually checking if the unresolved symbols are available in
>the GPLONLY area? That would allow you to be more precise.

I would have to check for all the permutations between module and
kernel.  With and without symbol versions, with and without gplonly,
with and without ppc64 function descriptor renaming, with and without
ia64 function descriptor renaming, ...

Given the current modutils code, that is just too messy.  The code was
written for a single set of names and it has been hacked since then,
with special cases added onto special cases.  The symbol handling needs
a complete rewrite, which will occur in modutils 2.5.  In modutils 2.4
I just ignore the gplonly symbols during symbol import unless the
module is gpl licenced.  Simpler, if less precise.  Since it only
affects BOMs, I don't really care that much about precise error
messages.

