Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263170AbTDRQHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTDRQFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:05:15 -0400
Received: from [213.171.53.133] ([213.171.53.133]:22029 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S263139AbTDRQEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:04:50 -0400
Date: Fri, 18 Apr 2003 20:23:01 +0400
From: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
X-Mailer: The Bat! (v1.61)
Reply-To: "Ruslan U. Zakirov" <cubic@wr.miee.ru>
Organization: CITL MIEE
X-Priority: 3 (Normal)
Message-ID: <54252003171.20030418202301@wr.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: [autofs] 2.5+autofs-pre10+submount+smbfs expire problems.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello.
I've writed "exec map", that submount another autofs with another program
map, wich return fstype=smbfs.
I've got tree
autofs
      autofs submount
             smbfs
             smbfs
             ...
      autofs submount
             smbfs
             smbfs
             ...
      ...
I use autofs4 protocol, autofs4 and smbfs compiled staticaly.
Expiration problem occur. Smbfs mounts never unmount.
Autofs submounts expire ok, when I don't have third level(smbfs mounts).
Log at the end of letter.


May be I've missed something in configuration, but I don't think so.
I'll try same on 2.4.20 tonight.

             Best regards, Ruslan.

PS: Something wrong with my email and Autofs mailing list, my letters
don't appear on the list, but mailman said that I'm subscriber.


automount[9918]: expired /net/spectre-pc//music
automount[9900]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1784] timed out!
automount[9920]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9920]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1785] timed out!
automount[9923]: running expiration on path /net/ghost-pc//Video
automount[9923]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1786] timed out!
automount[9939]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9939]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1787] timed out!
automount[9958]: running expiration on path /net/ghost-pc//Video
automount[9958]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1788] timed out!
automount[9959]: running expiration on path /net/ghost-pc//Video
automount[9959]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1789] timed out!
automount[9962]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9962]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1790] timed out!
automount[9964]: running expiration on path /net/ghost-pc//Video
automount[9964]: expired /net/ghost-pc//Video
kernel: smb_add_request: request [c38bfebc, mid=1791] timed out!
automount[9980]: running expiration on path /net/ghost-pc//Video
kernel: SMB connection re-established (-5)
automount[9980]: expired /net/ghost-pc//Video

