Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265164AbRF0AbB>; Tue, 26 Jun 2001 20:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbRF0Aav>; Tue, 26 Jun 2001 20:30:51 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:13323 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S265161AbRF0Aal>; Tue, 26 Jun 2001 20:30:41 -0400
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [PATCH] User chroot
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D1205FB@nasdaq.ms.ensim.com>
Message-Id: <E15F3KH-0003fd-00@pmenage-dt.ensim.com>
Date: Tue, 26 Jun 2001 17:37:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D1205FB@nasdaq.ms.ensim.com>,
you write:
>
>Safe, perhaps, but also completely useless: there is no way the user
>can set up a functional environment inside the chroot.  In other
>words, it's all pain, no gain.
>

It could potentially be useful for a network daemon (e.g. a simplified
anonymous FTP server) that wanted to be absolutely sure that neither it
nor any of its libraries were being tricked into following a bogus
symlink, or a "/../" in a passed filename. After initialisation, the
daemon could chroot() into its data directory, and safely only serve
the set of files within that directory hierarchy.

This could be regarded as the wrong way to solve such a problem, but
this kind of bug seems to be occurring often enough on BugTraq that it
might be useful if you don't have the resources to do a full security
audit on your program (or if the source to some of your libraries
isn't available).

Paul
