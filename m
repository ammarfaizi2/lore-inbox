Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVG1WtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVG1WtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVG1WtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:49:09 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:63387 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261582AbVG1WtI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:49:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CedPzY61yWz0mA1l5IOFbdgBwRMbwXiN0Uuev344NwGHgULBofmNdHxZv5/2S5a5Eg3Y38grQosS5eNWKr/e+5MfILP0nxBKtdX98UQ0ykq+4FjEXJc6yUy/oAacyT/67dw0Y1oRiRVqIQJzpXH/inI4NsEiU1aFB00fp2E0sdw=
Message-ID: <564d96fb050728154923ba8663@mail.gmail.com>
Date: Thu, 28 Jul 2005 22:49:07 +0000
From: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
Reply-To: =?ISO-8859-1?Q?Rafael_Esp=EDndola?= <rafael.espindola@gmail.com>
To: gentoo-dev@gentoo.org, gentoo-catalyst@gentoo.org,
       linux-kernel@vger.kernel.org
Subject: unmounting a filesystem mounted by /init (initramfs)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to build a system that uses a unionfs as root. The init
script is based on the one used by gentoo and uses initramfs. The
problem is how to remount the unionfs constituents read only during
halt.

cat /proc/mounts displays /dev/hda1 (ext2) mounted rw in /memory. The
problem is that /memory is no longer visible after the init script did
a chroot and a

mount -o remount,ro /dev/hda1

says that /dev/hda1 is not mounted!

does any anyone has an idea?

Thanks,
Rafael
