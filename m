Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312311AbSCYHqS>; Mon, 25 Mar 2002 02:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312291AbSCYHqI>; Mon, 25 Mar 2002 02:46:08 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:21267 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S312311AbSCYHqA>; Mon, 25 Mar 2002 02:46:00 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Date: Mon, 25 Mar 2002 08:45:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.4.19 do_adjtimex parameter checking
CC: linux-kernel@vger.kernel.org
Message-ID: <3C9EE38F.5986.2DAB75@localhost>
In-Reply-To: <3C9DA6F9.1CD32F3D@yahoo.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.9/Sophos-3.53+2.6+2.03.083+07 January 2002+71269@20020325.073529Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Mar 2002, at 5:14, Paul Gortmaker wrote:

> Okay then, the bug still stands, but you want a different fix really.
> The user that reported it to me was infact setting multiple bit
> combos, which you indicate as taboo (but currently allowed). So 
> when multiple bit combos are given, we can either do:
> 
> a) return -EINVAL if more than ADJ_OFFSET_SINGLESHOT is set
> b) clear/ignore any bits above and beyond ADJ_OFFSET_SINGLESHOT.
> 
> As you are a time guru, please indicate which is preferable and I will
> bounce Rusty an appropriate patch.

Thanks for the flowers,

my preference is EINVAL of course. Silently adjusting parameters is bad 
IMHO.

Regards,
Ulrich

