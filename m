Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269250AbUISPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269250AbUISPAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 11:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269248AbUISPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 11:00:13 -0400
Received: from spanner.eng.cam.ac.uk ([129.169.8.9]:54775 "EHLO
	spanner.eng.cam.ac.uk") by vger.kernel.org with ESMTP
	id S269250AbUISPAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 11:00:09 -0400
Date: Sun, 19 Sep 2004 16:00:04 +0100 (BST)
From: "P. Benie" <pjb1008@eng.cam.ac.uk>
To: Pascal Schmidt <pascal.schmidt@email.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Design for setting video modes, ownership of sysfs attributes
In-Reply-To: <E1C92WT-00005z-7q@localhost>
Message-ID: <Pine.HPX.4.58L.0409191541030.24772@punch.eng.cam.ac.uk>
References: <2FYdH-10h-5@gated-at.bofh.it> <2G6Et-6D7-31@gated-at.bofh.it>
 <2G6Et-6D7-31@gated-at.bofh.it> <E1C92WT-00005z-7q@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004, Pascal Schmidt wrote:
> On Sun, 19 Sep 2004 12:00:21 +0200, you wrote in linux.kernel:
> > The FDs 0, 1 and posibly 2 will be the console.
>
> *The* console? They can all be connected to different console
> devices (think redirection). I'd think for video mode questions,
> you'd look at stdout...

Early versions of stty made that mistake - to find out what settings your
printers had, you ended up printing the output of stty on paper.

If you're going to subvert an fd, use stdin, not stdout.
stdin is less valuable most commands use argv rather than stdin, and it
allows you to retreive the output of a command using the shell `backtick`
operators.

Peter

