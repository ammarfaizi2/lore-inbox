Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUDQVdf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 17:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUDQVdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 17:33:35 -0400
Received: from holomorphy.com ([207.189.100.168]:52364 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263104AbUDQVdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 17:33:33 -0400
Date: Sat, 17 Apr 2004 14:33:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040417213333.GS743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417212958.GA8722@flea>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 12:38:55PM -0700, William Lee Irwin III wrote:
>> Marc Singer reported an issue where an embedded ARM system performed
>> poorly due to page replacement potentially prematurely replacing
>> mapped memory where there was very little mapped pagecache in use to
>> begin with.
>> Marc Singer has results where this is an improvement, and hopefully can
>> clarify as-needed. Help determining whether this policy change is an
>> improvement for a broader variety of systems would be appreciated.

On Sat, Apr 17, 2004 at 02:29:58PM -0700, Marc Singer wrote:
> I have some numbers to clarify the 'improvement'.
> Setup:
>   ARM922 CPU, 200MHz, 32MiB RAM
>   NFS mounted rootfs, tcp, hard, v3, 4K blocks
>   Test application copies 41MiB file and prints the elapsed time
> The two scenarios differ only in the setting of /proc/sys/vm/swappiness.

This doesn't match your first response. Anyway, this one is gets
scrapped. I guess if swappiness solves it, then so much the better.


-- wli
