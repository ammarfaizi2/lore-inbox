Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSLHVUz>; Sun, 8 Dec 2002 16:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLHVUz>; Sun, 8 Dec 2002 16:20:55 -0500
Received: from holomorphy.com ([66.224.33.161]:61077 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261594AbSLHVUy>;
	Sun, 8 Dec 2002 16:20:54 -0500
Date: Sun, 8 Dec 2002 13:28:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
Message-ID: <20021208212808.GY9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>, anton@samba.org,
	linux-kernel@vger.kernel.org
References: <3DF3B7FB.9010902@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF3B7FB.9010902@colorfullife.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
>> ie during the compile we scheduled 56283 times, and 41984 of them were
>> caused by pipes.

On Sun, Dec 08, 2002 at 10:22:03PM +0100, Manfred Spraul wrote:
> The linux pipe implementation has only a page sized buffer - with 4 kB 
> pages, transfering 1 MB through a pipe means at 512 context switches.

Hmm. What happened to that pipe buffer size increase patch? That sounds
like it might help here, but only if those things are trying to shove
more than 4KB through the pipe at a time.


Bill
