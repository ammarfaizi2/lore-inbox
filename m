Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbTKECPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 21:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTKECPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 21:15:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:6359 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262712AbTKECPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 21:15:20 -0500
Date: Wed, 5 Nov 2003 13:15:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory notification.
Message-Id: <20031105131509.23d38c58.sfr@canb.auug.org.au>
In-Reply-To: <E1AH5ED-0005Qm-00@aqualene.uio.no>
References: <E1AH5ED-0005Qm-00@aqualene.uio.no>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003 18:44:29 +0100 Terje Malmedal <terje.malmedal@usit.uio.no> wrote:
>
> Modifications of existing files via NFS are not picked up by the
> directory notification system.
> 
> kernel is 2.4.22, I'm testing with the example program from
> /usr/src/linux/Documentation/dnotify.txt
> 
> I get notifications on the following: 
> nfs-server# echo hello >> existing.file   
> nfs-client# echo hello > new.file
> 
> But not on this: 
> nfs-client# echo hello >> existing.file 
> 
> I guess the problem of detecting changes done via NFS is similar to
> the problem of multiple hard-links to the same file, which is
> documented as not supported.
> 
> Is this something that can be fixed, or is it going to be too
> difficult to go from NFS-handle and back to the directory it came
> from?

Are you running the program that expects notifies on the NFS server or the
client? If on the client, you will never get notifies for modifications
made on the server or other clients.  If on the server, it needs looking
at as you should get the notifies (I think - it has been a while since I
last looked at the NFS server code).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
