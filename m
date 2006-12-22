Return-Path: <linux-kernel-owner+w=401wt.eu-S1423189AbWLVG5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423189AbWLVG5y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 01:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423185AbWLVG5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 01:57:54 -0500
Received: from mx28.mail.ru ([194.67.23.67]:3285 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423189AbWLVG5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 01:57:53 -0500
X-Greylist: delayed 7118 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 01:57:53 EST
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19: File system corruption "stuck" until device is replugged
Date: Fri, 22 Dec 2006 07:59:05 +0300
User-Agent: KMail/1.9.5
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612220759.11961.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I had USB stick (fat32) that reported file system corruption on mount and 
hence was mounted read-only. No amount of umount/dosfsck/mount could make it 
rw again. dosfsck reported device as clean but it still would mount ro and I 
continued to see directory that had been deleted by the very first dosfsck 
run! I unplugged it, looked under Win2k - it was OK - and only then did I 
notice that directory claimed as corrupted did not even exist. Replugging 
it - mounted OK.

I am not sure if this is a bug or "work as designed". May be this is specific 
fat32 problem; still it does not look right?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFi2YfR6LMutpd94wRAquCAKC3n8DjRGRqDYdfP6tNGvlg5sG0MQCfQRNJ
89HQuNaAWuLzJkkKayVrLks=
=m0rH
-----END PGP SIGNATURE-----
