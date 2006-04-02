Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWDBIkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWDBIkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWDBIkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:40:04 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:60848 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932168AbWDBIkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:40:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wxXGI34qv25Zcddop99F+IBjCDGZI6QUs/gznPNvJntk+FTRqtfVTScdxYh0XM4hg6hzac//tFKeD97wgRja6wTw48H9e9OnVgC7QfJppS3D3d4YcUI4gx4qoUTWxNSRixoTObmt4P6wJNBle98zkg6CxfDj3hnra28VEZKn4dw=  ;
Message-ID: <442F5721.2040906@yahoo.com.au>
Date: Sun, 02 Apr 2006 14:46:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-ck3
References: <200604021401.13331.kernel@kolivas.org>
In-Reply-To: <200604021401.13331.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> These are patches designed to improve system responsiveness and interactivity. 
> It is configurable to any workload but the default ck patch is aimed at the 
> desktop and cks is available with more emphasis on serverspace.
> 
> THESE INCLUDE THE PATCHES FROM 2.6.16.1 SO START WITH 2.6.16 AS YOUR BASE
> 
> Apply to 2.6.16
> http://www.kernel.org/pub/linux/kernel/people/ck/patches/2.6/2.6.16/2.6.16-ck3/patch-2.6.16-ck3.bz2
> 

The swap prefetching here, and the one in -mm AFAIKS still do not follow
the lowmem reserve ratio correctly. This might explain why prefetching
appears to help some people after updatedb swaps stuff out to make room
for pagecache -- it may actually be dipping into lower zones when it
shouldn't.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
