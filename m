Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130418AbQKQTMA>; Fri, 17 Nov 2000 14:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130365AbQKQTLu>; Fri, 17 Nov 2000 14:11:50 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:43164 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S129750AbQKQTLk>; Fri, 17 Nov 2000 14:11:40 -0500
Date: Fri, 17 Nov 2000 18:24:51 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: patch: loop remapper
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <3A1577F3.BCE3892D@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <20001116182526.A848@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
<snip>
> 
> The builtin transfer functions (none and xor) work with the changes,
> but external crypto additions may not. The reason is that the raw
> buf and loop buf passed to them can now be identical (the previous
> version always used getblk() to get a new buffer to work on).
> 
<snip>

The crypto-api from the international kernel patch has recently defined
that the encryption functions contained in it must be able to encrypt
in-place. This maps directly to the loop-gen driver, so I don't see a
problem here. (Other than that there is no real patch-int-2.4.x out
there yet). However, the ciphers have not been checked to conform to
that definition.

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
