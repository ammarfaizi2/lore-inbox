Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWIVOAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWIVOAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWIVOAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:00:16 -0400
Received: from caffeine.uwaterloo.ca ([129.97.134.17]:1753 "EHLO
	caffeine.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932399AbWIVOAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:00:15 -0400
Date: Fri, 22 Sep 2006 10:00:07 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dax Kelson <dax@gurulabs.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-ID: <20060922140007.GK13639@csclub.uwaterloo.ca>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45130792.9040104@zytor.com>
User-Agent: Mutt/1.5.9i
From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lsorense@csclub.uwaterloo.ca
X-SA-Exim-Scanned: No (on caffeine.csclub.uwaterloo.ca); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 02:43:46PM -0700, H. Peter Anvin wrote:
> 7zip (LZMA) decompresses quickly, and the decompressor text is actually 
> smaller than the equivalent for gzip.  Quite nice.
> 
> What is not nice is the code for the compressor, which is a total mess. 
>  I have been holding out on implementing LZMA on kernel.org, because 
> just as zip (deflate) didn't become common in the Unix world until an 
> encapsulation format that handles things expected in the Unix world, 
> e.g. streaming, was created (gzip), I don't think LZMA is going to be 
> widely used until there is an "lzip" which does the same thing.  I 
> actually started the work of adding LZMA support to gzip, but then 
> realized it would be better if a new encapsulation format with proper 
> 64-bit support everywhere was created.

It doesn't handle streaming?

So you can't do: tar c dirname | 7zip dirname.tar.7z ?

--
Len Sorensen
RuggedCom
