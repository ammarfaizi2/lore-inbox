Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131987AbRAJOzG>; Wed, 10 Jan 2001 09:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132989AbRAJOy4>; Wed, 10 Jan 2001 09:54:56 -0500
Received: from [64.64.109.142] ([64.64.109.142]:10515 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S131987AbRAJOyp>; Wed, 10 Jan 2001 09:54:45 -0500
Message-ID: <3A5C778C.CFB363F3@didntduck.org>
Date: Wed, 10 Jan 2001 09:54:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: antirez@invece.org
CC: linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
In-Reply-To: <20010110174859.R7498@prosa.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

antirez wrote:
> 
> Hi all,
> 
> The attached patch converts many occurences of '* 4' in the networking code
> (often used to convert in bytes the TCP data offset and the IP header len)
> to the faster '<< 2'. Since this was a quite repetitive work it's better
> if someone double-check it before to apply the patch.
> The patch is for linux-2.4.

This patch isn't really necessary, because GCC will automatically
convert multiplications and divisions by powers of two to use shifts.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
