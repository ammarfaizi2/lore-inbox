Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281381AbRKEWJ5>; Mon, 5 Nov 2001 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281382AbRKEWJs>; Mon, 5 Nov 2001 17:09:48 -0500
Received: from milsum.Biomed.McGill.CA ([132.206.111.48]:11792 "EHLO
	milsum.biomed.mcgill.ca") by vger.kernel.org with ESMTP
	id <S281381AbRKEWJh>; Mon, 5 Nov 2001 17:09:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Lavoie <clavoie@bmed.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: File resource leak in 2.2.19?
Date: Mon, 5 Nov 2001 17:09:36 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105220945Z281381-17409+8838@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I came to my work cluster only to find node4 dead. On the console, 

"VFS: file-max limit 4096 reached"

Trying to login gave an error message about loading the shared libraries 
required (since it couldn't get a file descriptor to load it, I guess)

The exact situation is an NFS share, hosted on a computer called 'node4'; 
files are accessed a couple of thousand times daily, read/write from a single 
other machine thru user-space NFS daemon from Progeny 1.0, which then relays 
X and/or VNC to a given Windows workstation. That's about the only access 
pattern to the files.

It's possible that the said files will open from the node itself (Without 
going thru NFS, but thru a strategically placed symlink), but I sincerely 
doubt it happened.

Is there any known resource leak in 2.2.19 and up ('only' patched with MOSIX 
0.98.0) that will exaust the available 'open file' resources?

Yours Truly,
Christian Lavoie
clavoie@bmed.mcgill.ca
