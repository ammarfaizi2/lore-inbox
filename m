Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUADRTU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUADRTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:19:20 -0500
Received: from vsmtp2.tin.it ([212.216.176.222]:34810 "EHLO vsmtp2alice.tin.it")
	by vger.kernel.org with ESMTP id S265766AbUADRTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:19:18 -0500
Subject: Re: 2.4.23 oops
From: Cristiano De Michele <demichel@na.infn.it>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040104143555.GF3728@alpha.home.local>
References: <1073223226.1695.10.camel@cripat.acasa-tr.it>
	 <20040104143555.GF3728@alpha.home.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics
Message-Id: <1073236750.2327.2.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 18:19:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok you were right it was the RAM, disabling the bank interleave and
increasing the CAS latency in the BIOS settings it seems
that now my system is pretty stable (using memtest86)

thx for your help
bye bye Cristiano

On Sun, 2004-01-04 at 15:35, Willy Tarreau wrote:
> Hi !
> 
> On Sun, Jan 04, 2004 at 02:33:46PM +0100, Cristiano De Michele wrote:
> 
> > Jan  3 04:39:42 cripat kernel: EFLAGS: 00010016
> > Jan  3 04:39:42 cripat kernel: eax: 616d7157   ebx: 6d6e6f72   ecx:
> > c8a5c000   edx: 73694400
> 
> This is weird, eax, ebx and edx contain portions of text :
>   eax="Wqma"
>   ebx="ronm"
>   edx="siD\0"
> 
> Perhaps it's pure coincidence, but it may also be a part of a URL or
> temporary file name. Could you run memtest86 on you system to check
> that you don't have RAM defects ?
> 
> Willy
-- 
  Cristiano De Michele,
  Department of Physics,
  University "Federico II" of Naples
