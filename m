Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUAMUlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUAMUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:41:50 -0500
Received: from [212.28.208.94] ([212.28.208.94]:55305 "HELO dewire.com")
	by vger.kernel.org with SMTP id S265563AbUAMUls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:41:48 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Autofs question (try 2)
Date: Tue, 13 Jan 2004 21:41:45 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401132141.45772.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first message was cut short, sorry

I grabbed the auto.smb script for mounting samba/windows shares. One of the flaws is that I'd
like to get around is that it must be configured as root and most importantly that I don't see who 
is requesting the mount. I was thinking along the line of mounting shares in /cifs/$USER/servers/share
or simply mounting the share for the first user using the mount point (essentially single user machines
anyway).

the auto.smb script is running as root and I printed some info in root.c at the revalidate

Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=505 name=10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 automount[22233]: attempting to mount entry /cifs/10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
Jan 12 18:49:06 h6n2fls33o811 logger: uid=0(root) gid=0(root) grupper=0(root)
Jan 12 18:49:07 h6n2fls33o811 kernel: autofs4_root_revalidate, uid=0 name=10.1.1.4
Jan 12 18:49:08 h6n2fls33o811 last message repeated 10 times
and lots more from mounting with uid=0

Is there any simple way of passing the first uid to the automounter?

-- robin

