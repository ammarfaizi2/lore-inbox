Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTDTPqe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTDTPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:46:33 -0400
Received: from WebDev.iNES.RO ([80.86.100.174]:36481 "EHLO webdev.ines.ro")
	by vger.kernel.org with ESMTP id S263617AbTDTPqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:46:33 -0400
Date: Sun, 20 Apr 2003 18:58:33 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: Re: oops in 2.5.68-mm1
In-Reply-To: <Pine.LNX.4.50L0.0304201843300.1931-200000@webdev.ines.ro>
Message-ID: <Pine.LNX.4.50L0.0304201850130.1931-100000@webdev.ines.ro>
References: <Pine.LNX.4.50L0.0304201843300.1931-200000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sun, 20 Apr 2003, Andrei Ivanov wrote:

> 
> I'm not sure that this caused it, but I was doing an 'emerge rsync' in my 
> gentoo, and when 'emerge' was 'Updating Portage cache', the system was 
> slow, top or jed wouldn't start, and there was a 'chmod'(started probably 
> by 'emerge') in D state.
> 

Hmm... I think I found what caused it. I've mounted a smb share, went into 
a directory on the share, where there are 2 files:

-r--------    1 root     root        48281 Apr 11 21:05 Cats & Dogs (RO).txt
-r--------    1 root     root     730341376 Apr 11 21:04 Cats And Dogs.avi

I typed less Cats<tab>, and then &<tab>, and here it was stuck, and the 
kernel oopsed. If I type less Cats<tab>, and then \&<tab>, it works, but 
without the \ in front of the &, the shell gets stuck in D state.

The remote host, from which I mounted the share, runs 
kernel 2.4.20-gentoo-r1.
