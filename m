Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283040AbRK1Pjq>; Wed, 28 Nov 2001 10:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282996AbRK1Pjg>; Wed, 28 Nov 2001 10:39:36 -0500
Received: from denise.shiny.it ([194.20.232.1]:53690 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S282167AbRK1PjT>;
	Wed, 28 Nov 2001 10:39:19 -0500
Message-ID: <XFMail.20011128163916.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01112814012701.00944@manta>
Date: Wed, 28 Nov 2001 16:39:16 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Small security bug with misconfigured access rights
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, I don't know if it is really a bug.

Create a directory like this:

# ls -la
total 12
drwxr-sr-x   2 pochini  root         4096 Nov 28 16:33 .
drwxr-xr-x  32 pochini  users        8192 Nov 28 16:25 ..

Sgid bit is set and the directory is owned by me and the
group is root (yes, it shouldn't be).

When I create a file here, it gets the root group even
if I don't belong to it.

[kernel 2.4.5]


Bye.

