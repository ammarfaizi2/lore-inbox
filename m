Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWG1Ey6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWG1Ey6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 00:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbWG1Ey6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 00:54:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:52536 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751924AbWG1Ey6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 00:54:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=idRpFmyR6T++NIUNKlBsf+iAzoRiLqYv3YO1OurUqTjYabVM5hPMb5fN+i86KZjRSruAR6b9mpajpdijyDxQCzptEGHHjec9la7NVeoilNaXdnMrAqKq05JlsZmdvbED1V7NFhxbSlvb/nNb/itVwraXdAubnLuKxwArHTVivpA=
Message-ID: <787b0d920607272154i44fea139pdff9f7395079779d@mail.gmail.com>
Date: Fri, 28 Jul 2006 00:54:56 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: adobriyan@gmail.com, linux-kernel@vger.kernel.org,
       jsipek@fsl.cs.sunysb.edu, B.Steinbrink@gmx.de
Subject: Re: [RFC] #define rwxr_xr_x 0755
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan writes:

> Every time I try to decipher S_I* combos I cry in pain. Often I just
> refer to include/linux/stat.h defines to find out what mode it is
> because numbers are actually quickier to understand.
>
> Compare and contrast:
>
>       0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> I'd say #2 really sucks.

Damn right.

I'd be very happy to remove (or #ifndef __KERNEL__ as needed) the
dreadful S_FOO macros. I'd be much happier with plain old octal,
as is normally used for both syscalls and the chmod command.

(the non-octal nonsense was probably invented for porting
software to non-UNIX systems)

If you like the ls way though, you might as well add the file
type notation:  drwxr_xr_x, _r__r__r__, _rw_r__r__, etc.
That's not too bad. Plain octal is best though.
