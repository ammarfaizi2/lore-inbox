Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130175AbRB1OCQ>; Wed, 28 Feb 2001 09:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130176AbRB1OCI>; Wed, 28 Feb 2001 09:02:08 -0500
Received: from t2.redhat.com ([199.183.24.243]:33782 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S130175AbRB1OBs>; Wed, 28 Feb 2001 09:01:48 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <EOFHHHCCDNNKDAAA@shared1-mail.whowhere.com> 
In-Reply-To: <EOFHHHCCDNNKDAAA@shared1-mail.whowhere.com> 
To: daveanderson@eudoramail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't compilete 2.4.2 kernel 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Feb 2001 14:01:26 +0000
Message-ID: <7974.983368886@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


daveanderson@eudoramail.com said:
> /usr/include/bits/errno.h:25: linux/errno.h: No such file or directory

Your glibc include files are broken. Rather than having their own copy of 
the /usr/include/linux/ directory, they have a symlink into 
/usr/src/linux/include/linux.

The correct fix is to put the kernel header files against which your glibc 
was compiled into the /usr/include/linux/ directory. But it should suffice, 
for now, to fix the symlink which you've broken by moving your kernel 
sources.



--
dwmw2


