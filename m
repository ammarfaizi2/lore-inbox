Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030628AbWBQQUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbWBQQUc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030633AbWBQQUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:20:32 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:23252 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030628AbWBQQUb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:20:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Lm64nFSrukdHl9XEq+qISTxjEmjKfyceOW80F8sO7zDkOyKA0dd4pvXLlDo998E8L3uRx++9MgaPOsiOak48kggniLA4nPGqlW6qPypNY9t4h4pKpAxRO7E7gbtJrM0JcyyUhVZeqEvJ13Bke8lglRew0ewZOk963HYJv0S+xS0=
Message-ID: <5d4799ae0602170820j33795815u7104bd41c7fe7e67@mail.gmail.com>
Date: Sat, 18 Feb 2006 03:20:30 +1100
From: Kris Shannon <kris.shannon.kernel@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Separate Initramfs dependency on initrd (and therefore ramdisks)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of distributions (most importantly for me - Debian) use the
initrd as initramfs facility
I assumed that the passing of the data block would be independent of
ram disks seeing as
not using a ram disk was one of the major reasons for initramfs,  but
it seems that you need
CONFIG_BLK_DEV_INITRD=y which depends on CONFIG_BLK_DEV_RAM=y

Would a patch separating out the init image handling from the initrd
handling be welcome
and if so should the resulting init image code be dependant on a
CONFIG variable or
always on (like initramfs is now)

The only reference to this I found in the archives was:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0508.1/0097.html
