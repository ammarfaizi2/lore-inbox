Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUGSKnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUGSKnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUGSKnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:43:50 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:10237 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264960AbUGSKnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:43:33 -0400
Message-ID: <40FBA5D2.90107@mindspring.com>
Date: Mon, 19 Jul 2004 03:43:30 -0700
From: Steve Bangert <sbangert@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: make rpm broken in 2.6.8-rc2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[root@localhost linux-2.6]# make rpm
make clean
set -e; cd ..; ln -sf /usr/src/linux-2.6 kernel-2.6.8rc2
set -e; cd ..; tar -cz  -f kernel-2.6.8rc2.tar.gz kernel-2.6.8rc2/.
set -e; cd ..; rm kernel-2.6.8rc2
set -e; \
/bin/sh /usr/src/linux-2.6/scripts/mkversion > 
/usr/src/linux-2.6/.tmp_version
set -e; \
mv -f /usr/src/linux-2.6/.tmp_version /usr/src/linux-2.6/.version
rpmbuild --target i386 -ta ../kernel-2.6.8rc2.tar.gz
Building target platforms: i386
Building for target i386
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.72624
+ umask 022
+ cd /usr/src/redhat/BUILD
+ LANG=C
+ export LANG
+ cd /usr/src/redhat/BUILD
+ rm -rf kernel-2.6.8rc1
+ /usr/bin/gzip -dc /usr/src/kernel-2.6.8rc1.tar.gz
+ tar -xf -
 
gzip: /usr/src/kernel-2.6.8rc1.tar.gz: unexpected end of file
tar: Unexpected EOF in archive
tar: Unexpected EOF in archive
tar: Error is not recoverable: exiting now
error: Bad exit status from /var/tmp/rpm-tmp.72624 (%prep)
 
 
RPM build errors:
    Bad exit status from /var/tmp/rpm-tmp.72624 (%prep)
make[1]: *** [rpm] Error 1
make: *** [rpm] Error 2
[root@localhost linux-2.6]#


Steve Bangert
