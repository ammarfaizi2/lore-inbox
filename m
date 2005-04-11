Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVDKKdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVDKKdy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVDKKdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:33:54 -0400
Received: from mail.portrix.net ([212.202.157.208]:9663 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261746AbVDKKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:33:53 -0400
Message-ID: <425A52AB.5020904@ppp0.net>
Date: Mon, 11 Apr 2005 12:34:19 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, sfrench@samba.org
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
In-Reply-To: <20050411012532.58593bc1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> bk-cifs.patch

This breaks the build on mips, ppc64, sparc, sparc64 with the
following error (defconfig, compared to mm2):

   CC [M]  fs/cifs/misc.o
fs/cifs/misc.c: In function `cifs_convertUCSpath':
fs/cifs/misc.c:546: error: case label does not reduce to an integer constant
fs/cifs/misc.c:549: error: case label does not reduce to an integer constant
fs/cifs/misc.c:552: error: case label does not reduce to an integer constant
fs/cifs/misc.c:561: error: case label does not reduce to an integer constant
fs/cifs/misc.c:564: error: case label does not reduce to an integer constant
fs/cifs/misc.c:567: error: case label does not reduce to an integer constant
make[2]: *** [fs/cifs/misc.o] Error 1
make[1]: *** [fs/cifs] Error 2
make: *** [fs] Error 2

See http://l4x.org/k for details.

Jan
