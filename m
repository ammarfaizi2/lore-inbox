Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRAKXHc>; Thu, 11 Jan 2001 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130204AbRAKXHV>; Thu, 11 Jan 2001 18:07:21 -0500
Received: from james.kalifornia.com ([208.179.0.2]:51759 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129994AbRAKXHL>; Thu, 11 Jan 2001 18:07:11 -0500
Message-ID: <3A5E3C18.18A6A42@linux.com>
Date: Thu, 11 Jan 2001 15:04:56 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <Pine.GSO.4.21.0101111337250.17363-100000@weyl.math.psu.edu> <3A5E0886.4389692E@Hell.WH8.TU-Dresden.De> <3A5E1E0D.B420A045@Hell.WH8.TU-Dresden.De>
Content-Type: multipart/mixed;
 boundary="------------CFFBC751E6363CED755E9B62"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CFFBC751E6363CED755E9B62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Udo A. Steinberg" wrote:

> "Udo A. Steinberg" wrote:
> >
> > The very strange stuff is umount at reboot:
> >
> > umount: none busy - remounted read-only
> > umount: /: device is busy
> > Remounting root-filesystem read-only
> > mount: / is busy
> > Rebooting.

Are you using devfs and do kernel threads have /dev/initctl open?

# lsof /dev
COMMAND     PID USER   FD   TYPE DEVICE SIZE NODE NAME
init          1 root   10u  FIFO    0,5       574 /dev/initctl
keventd       2 root   10u  FIFO    0,5       574 /dev/initctl
kapm-idle     3 root   10u  FIFO    0,5       574 /dev/initctl
kswapd        4 root   10u  FIFO    0,5       574 /dev/initctl
kreclaimd     5 root   10u  FIFO    0,5       574 /dev/initctl
bdflush       6 root   10u  FIFO    0,5       574 /dev/initctl
kupdate       7 root   10u  FIFO    0,5       574 /dev/initctl
i2oevtd       8 root   10u  FIFO    0,5       574 /dev/initctl
i2oblock      9 root   10u  FIFO    0,5       574 /dev/initctl
khubd        12 root   10u  FIFO    0,5       574 /dev/initctl
khttpd       16 root   10u  FIFO    0,5       574 /dev/initctl

-d


--------------CFFBC751E6363CED755E9B62
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

--------------CFFBC751E6363CED755E9B62--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
