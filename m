Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130697AbQLIXNU>; Sat, 9 Dec 2000 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130389AbQLIXNB>; Sat, 9 Dec 2000 18:13:01 -0500
Received: from james.kalifornia.com ([208.179.0.2]:30281 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S130697AbQLIXM2>; Sat, 9 Dec 2000 18:12:28 -0500
Message-ID: <3A32B528.8747332C@linux.com>
Date: Sat, 09 Dec 2000 14:41:44 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Rik van Riel <riel@conectiva.com.br>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swapoff weird
In-Reply-To: <20001209222427.A1542@bug.ucw.cz> <Pine.LNX.4.21.0012091941170.19389-100000@duckman.distro.conectiva> <20001209230615.C5542@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------0BF75B9DB646FDF9C6DCD837"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0BF75B9DB646FDF9C6DCD837
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> I can't swapoff.  Therefore filesystem is busy (it must be -- kernel
> might be writing to file on it!). And no way to get out of that.

It's busy because some portion of memory is in use.  manually kill things as
best you can.  this will clean out the swap.  once you've gotten all
applications killed cleanly you can forcibly reboot with little damage.  this
is pretty much the only way out.  we don't have any method (currently) to
turn off a swap file if it's deleted.

Some ideas for the future, /var/run/swap.inode files, some form of sysctl.

-d


--------------0BF75B9DB646FDF9C6DCD837
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------0BF75B9DB646FDF9C6DCD837--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
