Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTAUASf>; Mon, 20 Jan 2003 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAUASf>; Mon, 20 Jan 2003 19:18:35 -0500
Received: from news.cistron.nl ([62.216.30.38]:30983 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261733AbTAUASe>;
	Mon, 20 Jan 2003 19:18:34 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: /dev/initctl
Date: Tue, 21 Jan 2003 00:27:39 +0000 (UTC)
Organization: Cistron
Message-ID: <b0i45r$poa$1@ncc1701.cistron.net>
References: <20030120223459.57535.qmail@web21512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1043108859 26378 62.216.29.67 (21 Jan 2003 00:27:39 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030120223459.57535.qmail@web21512.mail.yahoo.com>,
Jim Holliaoke  <jholliaoke@yahoo.co.uk> wrote:
>    When I try to boot my linux system using a rescue
>disk, login as root, mount my root filesystem,
>pivot_root to it and try to execute '/sbin/init', I
>get an error that says 'error opening/writing control
>channel /dev/initctl'. I understand that /dev/initctl
>is a FIFO that used to pass messages to init and the
>error message is probably caused by the absence of the
>running process on the other end to pick up the
>message, but isn't this the feat that an initrd
>achieves with no special effort? Am I understanding
>this right or is executing init from an interactive
>shell prohibited?

Exactly, you cannot execute init from a shell. Init *must* have
process-id #1. If your shell is PID #1, try exec /sbin/init

If init isn't PID #1, it behaves like 'telinit'.

Mike.
-- 
They all laughed when I said I wanted to build a joke-telling machine.
Well, I showed them! Nobody's laughing *now*! -- acesteves@clix.pt

