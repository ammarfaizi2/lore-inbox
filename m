Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTKXNry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 08:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263439AbTKXNry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 08:47:54 -0500
Received: from [65.248.4.67] ([65.248.4.67]:50609 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S263356AbTKXNrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 08:47:52 -0500
Message-ID: <002301c3b291$9a2f50a0$34dfa7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: <tim@cambrant.com>
Cc: <linux-kernel@vger.kernel.org>
References: <001001c3b28d$183400e0$34dfa7c8@bsb.virtua.com.br> <20031124133120.GA13678@cambrant.com>
Subject: Re: Force Coredump
Date: Mon, 24 Nov 2003 11:48:10 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Done , but no coredump file

%ulimit -c unlimited
%./test
Segmention fault
%ls -lisa
test*    test.c


-----test.c ------
#include <stdio.h>

int main()
{
    int *i = 0;
    if(*i)
    exit(1);
}
------------------

test is owned by the same user of directory

att,
Breno
----- Original Message -----
From: <tim@cambrant.com>
To: "Breno" <brenosp@brasilsec.com.br>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 24, 2003 11:31 AM
Subject: Re: Force Coredump


> On Mon, Nov 24, 2003 at 11:15:51AM -0200, Breno wrote:
> > Anybody knows why ?
>
> Perhaps you don't have writing access to the directory where the program
is placed, or there is already a core file in the same directory, which you
don't have writing access to. Another possibility (more likely) is that
'ulimit -c' is set too low. Try typing 'ulimit -c unlimited' and see if that
works. This command will produce a core file for every segfault that occurs,
which may be inconvenient, so take a note of what ulimit is set to before
you change it.
>
> Hope that helps. Good luck.
>
> --
> Tim Cambrant <tim@cambrant.com>
> GPG KeyID 0x59518702
> Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

