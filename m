Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWEVTLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWEVTLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWEVTLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:11:00 -0400
Received: from terminus.zytor.com ([192.83.249.54]:14744 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750952AbWEVTK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:10:59 -0400
Message-ID: <44720CB6.7010908@zytor.com>
Date: Mon, 22 May 2006 12:10:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605212003.32063.s0348365@sms.ed.ac.uk> <e4t1la$u3p$1@terminus.zytor.com> <200605222007.19456.s0348365@sms.ed.ac.uk>
In-Reply-To: <200605222007.19456.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Monday 22 May 2006 19:58, H. Peter Anvin wrote:
> [snip]
>> Personally, I would like to suggest adding LZMA capability to gzip.
>> The gzip format already has support for multiple compression formats.
> 
> Any idea why this wasn't done for bzip2?

Yes, the bzip2 author I have been told was originally planning to do that, but then 
thought it would be harder to deploy that way (because gzip is a core utility, and people 
are nervous about making it larger.)

You'd have to ask him for the details, though.

It *is* true that there is a fair bit of code out there which sees a gzip magic number and 
expects to call deflate functions on it, without ever checking the compression type field. 
  However, even if there is a need for a new magic number, this can be done within the 
gzip code, or by forking gzip.

	-hpa
