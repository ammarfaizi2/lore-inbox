Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUIITIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUIITIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUIITIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:08:05 -0400
Received: from imap.gmx.net ([213.165.64.20]:60291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266777AbUIITGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:06:07 -0400
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <867288DA-0293-11D9-9E22-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: hfsplus bugs making coreutils testsuite fail
Date: Thu, 9 Sep 2004 21:07:42 +0200
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running the coreutil test suites, I found two differences between 
the hfsplus behaviour and that of other filesystems.

1. If I do:
   mkdir a; chmod 1777 a; touch a/b; su some_other_user -c "rm -rf a"
I get, on ext2:
   rm: cannot remove 'a': Permission denied
but on HFS+:
   rm: reading directory 'a/b': Not a directory
   rm: cannot remove directory 'a': Directory not empty

2. "ls -1F" appends suffixes to the filenames of pipes (|) and links 
(@).

--
Martin

