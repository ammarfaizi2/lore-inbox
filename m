Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262235AbREWGmE>; Wed, 23 May 2001 02:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbREWGly>; Wed, 23 May 2001 02:41:54 -0400
Received: from [202.9.134.47] ([202.9.134.47]:14241 "HELO enigma")
	by vger.kernel.org with SMTP id <S262235AbREWGlq>;
	Wed, 23 May 2001 02:41:46 -0400
Date: Wed, 23 May 2001 11:43:18 +0530
From: Manas Garg <mls@chakpak.net>
To: linux-kernel@vger.kernel.org
Subject: O_TRUNC problem on a full filesystem
Message-ID: <20010523114318.A8336@cygsoft.com>
Mail-Followup-To: Manas Garg <mls@chakpak.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Cygnet Software Ltd.
X-Editor: Vim
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if it should be classified as a bug, that's why I am calling it a
problem. Here is the description:

If the filesystem is full, obviously, I can't write anything to that any
longer. But if I open a file with O_TRUNC flag set, the file will be truncated.
Any program that opens a file with O_TRUNC flag set, wishes to write something
there later on. But because the filesystem is full, it can't write. It would
definitely happen if the file is not huge (TESTED). But I am not sure what
happens if the file _is_ huge (NOT TESTED).

I lost configuration files of a few programs this way. While exiting, they
opened their conf files with O_TRUNC flag but couldn't write anything there.

The kernel in use is 2.4.4.

	--manas
