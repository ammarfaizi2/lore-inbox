Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbSJILqv>; Wed, 9 Oct 2002 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261560AbSJILqu>; Wed, 9 Oct 2002 07:46:50 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:4231 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261555AbSJILqr> convert rfc822-to-8bit;
	Wed, 9 Oct 2002 07:46:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Date: Wed, 9 Oct 2002 13:53:33 +0200
User-Agent: KMail/1.4.1
Cc: akpm@digeo.com, riel@conectiva.com.br
References: <1034044736.29463.318.camel@phantasy>
In-Reply-To: <1034044736.29463.318.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091353.33286.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 04:38, Robert Love wrote:
> Attached patch implements an O_STREAMING file I/O flag which enables
> manual drop-behind of pages.
>
> If the file has O_STREAMING set then the user has explicitly said "this
> is streaming data, I know I will not revisit this, do not cache
> anything".  So we drop pages from the pagecache before our current
> index.  We have to fiddle a bit to get writes working since we do
> write-behind but the logic is there and it works.

Great ;-)
This is the nice way of doing what the akpm-patch did for me a while ago.

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

