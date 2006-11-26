Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967194AbWKZCPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967194AbWKZCPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 21:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967201AbWKZCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 21:15:24 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:19566 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S967194AbWKZCPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 21:15:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:X-YMail-OSG:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=c7Sv5BtUi3NceDUEnu1ExkLGl92LtbWBHM6Pr4rU+qRq2ONPD+Gf2vV6PDaDHaTdbWqIC3NeCelhfPRhH3SzFfvnVJlkgH2Fh4Oc9GVJSPMnoXuXLIb2K8r5U69c9w9Z7nTO1r9QUNybbHyU2Q9oFlrYaIg+jHAhO6VAKs5pBOA=  ;
X-YMail-OSG: O1II87sVM1lG8F0wMNmpkZLTCFzgJRsYxeehLJw_cOr6QTJONcG1HE_R.teZehORHVRF22lZiNeAc_gA0OxwzPDTBNxg2JLtsrnu5kfrEZPBb9vGQif9_Q--
Message-ID: <4568F851.90102@sbcglobal.net>
Date: Sat, 25 Nov 2006 20:13:37 -0600
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       Artiom Myaskouvskey <artiom.myaskouvskey@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi_limit_regions triggers link failure when CONFIG_EFI
 is not defined
References: <20061123021703.8550e37e.akpm@osdl.org> <35d909969a9b883d8ee15ee1df497fd9@pinky> <200611241805.45621.ak@suse.de>
In-Reply-To: <200611241805.45621.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 24 November 2006 17:59, Andy Whitcroft wrote:
>> The following patch is needed to get 2.6.19-rc6-mm1 to compile with
>> CONFIG_EFI disabled.  This is the 'shortest' fix.  However, it does
>> appear that there is some overlap with EFI implmentation partly
>> being in e820.c and partly in efi.c.  It might make sense to move
>> everything efi related over to efi.c.
> 
> It compiles here. And the ifdef status hasn't changed at all.

With the "easy fix" it compiles here, too.  Thanks!

> 
> Ah maybe your compiler failed to inline the function so the compiler
> couldn't optimize it away. What compiler were you using? Does it
> go away if you add a "inline" to efi_limit_regions()?
> 
> -Andi

Matt

