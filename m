Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUEZAIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUEZAIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUEZAIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:08:32 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:9679
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265267AbUEZAIb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:08:31 -0400
Date: Tue, 25 May 2004 20:17:00 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Odd symlink behaviour?
Message-ID: <20040525201700.A28595@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vanilla kernel 2.6.6.  / is ext3, /dev is on /

I noticed when I created a symlink, the perms were not 777 like I would have
expected.  See below.

[root@vegeta:/dev] v cdrom
ls: cdrom: No such file or directory
[root@vegeta:/dev] ln -s scd0 cdrom
[root@vegeta:/dev] v cdrom
lrwxr-xr-x    1 root     root            4 May 25 20:13 cdrom -> scd0
[root@vegeta:/dev] umask 0
[root@vegeta:/dev] ln -sf scd0 cdrom
[root@vegeta:/dev] v cdrom
lrwxrwxrwx    1 root     root            4 May 25 20:13 cdrom -> scd0
[root@vegeta:/dev] umask 022
[root@vegeta:/dev] uname -r
2.6.6
[root@vegeta:/dev] ln --version
ln (coreutils) 5.0.91

I have another filesystem which is reiserfs; It doesn't exibit this problem.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
