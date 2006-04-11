Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWDKBzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWDKBzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 21:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDKBzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 21:55:46 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:30802 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbWDKBzp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 21:55:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RpZIitN6FI05slNsq5p8eNd7ZEp5QDR1Bb3IwO0INJN2n93LATbjjrjwKcwQ/yB7UE2Beho9FepGHRVrFs7MppcxhxB9JK6FYwG9nFA3JCtptimvwVEqd/iBf5yL3QhClxy4a5ng2ZmTS4xspU/Agr4K1EEQLeAFpBXWQAfj5rQ=
Message-ID: <5d4799ae0604101855o72f01453l438d0d4d628bbb7@mail.gmail.com>
Date: Tue, 11 Apr 2006 11:55:45 +1000
From: "Kris Shannon" <kris.shannon.kernel@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Separate Initramfs dependency on initrd (and therefore ramdisks)
In-Reply-To: <5d4799ae0602170820j33795815u7104bd41c7fe7e67@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5d4799ae0602170820j33795815u7104bd41c7fe7e67@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of distributions (most importantly for me - Debian) use the
initrd as initramfs facility.  I assumed that the passing of the data
block would be independent of ram disks seeing as not using a ram
disk was one of the major reasons for initramfs,  but it seems that
you need CONFIG_BLK_DEV_INITRD=y which depends on
CONFIG_BLK_DEV_RAM=y

Would a patch separating out the init image handling from the initrd
handling be welcome and if so should the resulting init image code
be dependant on a CONFIG variable or always on (like initramfs is now)

The only reference to this I found in the archives was:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0508.1/0097.html
