Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316874AbSEXOZu>; Fri, 24 May 2002 10:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSEXOZt>; Fri, 24 May 2002 10:25:49 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316874AbSEXOZs>; Fri, 24 May 2002 10:25:48 -0400
Subject: Re: [PATCH] SUSv2 msgctl compliance
To: cyeoh@samba.org (Christopher Yeoh)
Date: Fri, 24 May 2002 15:45:52 +0100 (BST)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org,
        trivial@rustcorp.com.au
In-Reply-To: <15597.54106.812433.485262@gargle.gargle.HOWL> from "Christopher Yeoh" at May 24, 2002 03:44:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGKG-0006O6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For msgctl SUSv2 states:
> 
> "IPC_SET can only be executed by a process with appropriate privileges
> or that has an effective user ID equal to the value of msg_perm.cuid
> or msg_perm.uid in the msqid_ds data structure associated with
> msqid. Only a process with appropriate privileges can raise the value
> of msg_qbytes."
> 
> The current linux behaviour is to allow for the value of msg_qbytes to
> be raised even if the process is not privileged. The following
> patch (against 2.4.19pre8) fixes this problem:

This is not a bug. We have deemed all users to have appropriate priviledge
and in fact the generic SYS5 unix interpretation of this one seems if anything
to be bogus. We are standards compliant.

Alan
