Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264878AbUDUEy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264878AbUDUEy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUDUEy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:54:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24849 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264878AbUDUEy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 00:54:58 -0400
Date: Wed, 21 Apr 2004 06:53:44 +0200
From: Willy Tarreau <w@w.ods.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.26 released
Message-ID: <20040421045344.GJ596@alpha.home.local>
References: <200404141314.i3EDEbxv023592@hera.kernel.org> <20040420232312.GQ743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420232312.GQ743@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Tue, Apr 20, 2004 at 04:23:12PM -0700, William Lee Irwin III wrote:
> -		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
> +		return (mps_cpu & ~0x3) << 2 | 1 << (mps_cpu & 0x3);
                                        ^^^^
I think you wanted to put '<< 4' here instead of '<< 2'. Also, could you
put (useless for some) parenthesis to group the left side and the right
side of the bit-wise OR ? I'm always scared that someone changes it to
an addition with good intentions and changes the operators precedence
without noticing.

Cheers,
Willy

