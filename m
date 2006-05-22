Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWEVTOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWEVTOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 15:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWEVTOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 15:14:51 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:45581 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751135AbWEVTOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 15:14:51 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux Kernel Source Compression
Date: Mon, 22 May 2006 20:15:01 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0605211028100.4037@p34> <200605222007.19456.s0348365@sms.ed.ac.uk> <44720CB6.7010908@zytor.com>
In-Reply-To: <44720CB6.7010908@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605222015.01980.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 May 2006 20:10, H. Peter Anvin wrote:
> Alistair John Strachan wrote:
> > On Monday 22 May 2006 19:58, H. Peter Anvin wrote:
> > [snip]
> >
> >> Personally, I would like to suggest adding LZMA capability to gzip.
> >> The gzip format already has support for multiple compression formats.
> >
> > Any idea why this wasn't done for bzip2?
>
> Yes, the bzip2 author I have been told was originally planning to do that,
> but then thought it would be harder to deploy that way (because gzip is a
> core utility, and people are nervous about making it larger.)
>
> You'd have to ask him for the details, though.
>
> It *is* true that there is a fair bit of code out there which sees a gzip
> magic number and expects to call deflate functions on it, without ever
> checking the compression type field. However, even if there is a need for a
> new magic number, this can be done within the gzip code, or by forking
> gzip.

One trivial solution (that comes to mind) is by symlinking gunzip->unlzma (or 
similar) and having gzip's defaults change according to argv[0].

It's a bit of a shame bzip2 even exists, really. It really would be better if 
there was one unified, pluggable archiver on UNIX (and portables).

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
