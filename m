Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSG3Sr4>; Tue, 30 Jul 2002 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSG3Sr4>; Tue, 30 Jul 2002 14:47:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1286 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315449AbSG3Sr4>; Tue, 30 Jul 2002 14:47:56 -0400
Date: Tue, 30 Jul 2002 19:51:16 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Remco Treffkorn <remco@rvt.com>
Cc: "David S. Miller" <davem@redhat.com>, dan@embeddededge.com,
       benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 3 Serial issues up for discussion
Message-ID: <20020730195116.E7677@flint.arm.linux.org.uk>
References: <20020729181352.27999@192.168.4.1> <200207291246.43134.remco@rvt.com> <20020729.195414.31386335.davem@redhat.com> <200207301123.48322.remco@rvt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207301123.48322.remco@rvt.com>; from remco@rvt.com on Tue, Jul 30, 2002 at 11:23:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:23:47AM -0700, Remco Treffkorn wrote:
> The given solution presents almost zero overhead, but has the mentioned 
> problem. There is a way to allocate and free minor numbers, but that requires 
> storage. It could be handled like the fd_set's select uses. Just a bit field. 
> Bit cleared == minor available, bit set == in use.

core.c already knows which "slots" are in use and which aren't, so
allocation and freeing of minor numbers isn't that much of a problem.

The sole purpose behind this is to solicit is peoples opinions and
ideas on those three points I've raised.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

