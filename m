Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUBRNlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 08:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266948AbUBRNlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 08:41:03 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:54431 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266894AbUBRNk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 08:40:59 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.27477.679757.404161@laputa.namesys.com>
Date: Wed, 18 Feb 2004 16:40:37 +0300
To: "Marco Berizzi" <pupilla@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: ReiserFS corruption with samba 3.0.2a
In-Reply-To: <Sea2-DAV22IBirXXeQM0000aeb5@hotmail.com>
References: <Sea2-DAV22IBirXXeQM0000aeb5@hotmail.com>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Berizzi writes:
 > Hello.
 > 
 > I'm experimenting this problem with samba 3.0.2a and linux 2.4.24
 > with ReiserFS. When I copy (put) a large file (5GB) from a Windows NT
 > terminal server edition sp6a machine to the samba-linux box I get this
 > error:
 > 
 > Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4999052)[dev:blocknr]: bit already cleared
 > Feb 17 18:01:11 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:4997935)[dev:blocknr]: bit already cleared
 > Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902445)[dev:blocknr]: bit already cleared
 > Feb 17 18:02:48 Mimas kernel: ide0(3,8):vs-4080: reiserfs_free_block: free_block (0308:902286)[dev:blocknr]: bit already cleared
 > 

Are there any other error messages before these?

 > Samba 2.2.8a doesn't show this behaviour.
 > 
 > The linux box is Slackware 9.1 (gcc 3.2.3 linux 2.4.24 glibc 2.3.2).
 > It's easy for me to reproduce the problem.
 > 
 > Hints?

Did target file exist before copy?

Take latest version of reiserfsprogs from ftp.namesys.com and run fsck
(in the check mode) ide0(3,8).

Nikita.
