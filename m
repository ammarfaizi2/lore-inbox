Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbTLKHWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTLKHWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:22:10 -0500
Received: from holomorphy.com ([199.26.172.102]:49636 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264405AbTLKHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:22:07 -0500
Date: Wed, 10 Dec 2003 23:19:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, Nick Piggin <piggin@cyberone.com.au>,
       Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211071937.GA8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Nick Piggin <piggin@cyberone.com.au>,
	Donald Maner <donjr@maner.org>, Raul Miller <moth@magenta.com>,
	linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <1289530000.1071126517@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289530000.1071126517@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> You're probably thinking of 2:2 split patches.
>> 2:2 splits are at least technically ABI violations, which is probably
>> why this isn't merged etc. Applications sensitive to it are uncommon.
>> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
>> top of the process address space.

On Wed, Dec 10, 2003 at 11:08:38PM -0800, Martin J. Bligh wrote:
> You mean like we place the stack in the "ABI compliant place"? 
> Yeah, right ;-)

No specific address is ever cited as a requirement for stack placement;
stack immediately below text is merely given as a "typical arrangement".
i.e. "Although applications may control their memory assignments, the
typical arrangement appears below: [diagram and other bits]" It then
goes on to say, "Processes, therefore, shount _not_ depend on finding
their stack at a particular virtual address."

The process address space boundary is, however, stated as a requirement:
"the reserved area shall not consume more than 1GB of the address space."


-- wli
