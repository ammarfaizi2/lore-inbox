Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSGGWlM>; Sun, 7 Jul 2002 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGGWlL>; Sun, 7 Jul 2002 18:41:11 -0400
Received: from imailg1.svr.pol.co.uk ([195.92.195.179]:63840 "EHLO
	imailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316601AbSGGWlK>; Sun, 7 Jul 2002 18:41:10 -0400
Posted-Date: Sun, 7 Jul 2002 22:43:46 GMT
Date: Sun, 7 Jul 2002 23:43:45 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre10 DevFS + LVM OOPS
In-Reply-To: <3D28839A.4090709@fabbione.net>
Message-ID: <Pine.LNX.4.21.0207072338030.9595-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio.

> this happend creating a new a lv with the command lvcreate -L512M
> -ntest system It did 3 times in a row then it worked again. What was
> strange is that I was in one dir and unfortunalty I don't remember
> which and it was crashing. I changed dir and then it was working. In
> the first instance I didn't thought about taking notes but atleast I
> have a full trace (the machine didn't hang or reboot... it is still
> alive 100%).

This may be completely off-track but I've seen it cause wierd problems
in the past, so worth checking - was the directory you were in when the
machine crashed one that still existed as far as the file system was
concerned?

To test this, try the following...

	# cd /tmp
	# mkdir X
	# cd X
	# mv ../X ../Y
	# cd `pwd`
	bash: /tmp/X: No such file or directory
	#

...and then perform the test. As far as the test is concerned, the
current directory is /tmp/X but, as shown above, the file system reports
that the said directory doesn't exist, and it's not hard to work out
that you're actually in /tmp/Y instead.

Best wishes from Riley.

