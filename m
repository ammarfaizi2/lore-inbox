Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVDGHch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVDGHch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVDGHch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:32:37 -0400
Received: from main.gmane.org ([80.91.229.2]:50862 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261728AbVDGHcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:32:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [BUG mm] "fixed" i386 memcpy inlining buggy
Date: Wed, 06 Apr 2005 17:18:35 +0200
Message-ID: <d30uga$2j0$1@sea.gmane.org>
References: <200503291542.j2TFg4ER027715@earth.phy.uc.edu>	 <200504021526.53990.vda@ilport.com.ua>	 <1112718844.22591.15.camel@leto.cs.pocnet.net>	 <200504061314.27740.vda@port.imtp.ilyichevsk.odessa.ua> <1112789157.32279.13.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Mozilla Thunderbird 0.9 (Macintosh/20041103)
X-Accept-Language: en-us, en
In-Reply-To: <1112789157.32279.13.camel@leto.cs.pocnet.net>
Cc: gcc@gcc.gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The only thing that would avoid this is to either tell the compiler to
> never put esi/edi in memory (which I think is not possibly across
> different versions of gcc) or to always generate a single asm section
> for all the different cases.

Use __asm__ ("%esi") and __asm__ ("%edi").  It is not guaranteed that 
they access the registers always (you can still have copy propagation 
etcetera); but, if your __asm__ statement constraints match the register 
you specify, then you can be reasonably sure that good code is produced.

Paolo

