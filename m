Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286180AbRLJHmx>; Mon, 10 Dec 2001 02:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286181AbRLJHmn>; Mon, 10 Dec 2001 02:42:43 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:31731 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S286180AbRLJHm2>; Mon, 10 Dec 2001 02:42:28 -0500
Date: Sun, 9 Dec 2001 23:33:49 -0800
From: Chris Wright <chris@wirex.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on select:  How big can the empty buffer space be before select returns ready-to-write?
Message-ID: <20011209233349.C27109@figure1.int.wirex.com>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C145359.3090401@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C145359.3090401@candelatech.com>; from greearb@candelatech.com on Sun, Dec 09, 2001 at 11:16:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ben Greear (greearb@candelatech.com) wrote:
> For instance, it appears that select will return that a socket is
> writable when there is, say 8k of buffer space in it.  However, if
> I'm sending 32k UDP packets, this still causes me to drop packets
> due to a lack of resources...

udp has a fixed 8k max payload. did you try breaking up your packets?

cheers,
-chris
