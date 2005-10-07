Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbVJGPFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbVJGPFD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVJGPFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:05:01 -0400
Received: from cantor.suse.de ([195.135.220.2]:8148 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030299AbVJGPFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:05:01 -0400
From: Andreas Schwab <schwab@suse.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Ian Campbell <ijc@hellion.org.uk>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 'Undeleting' an open file
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
	<4343E611.1000901@perkel.com>
	<20051005144441.GC8011@csclub.uwaterloo.ca>
	<4343E7AC.6000607@perkel.com>
	<20051005153727.994c4709.fmalita@gmail.com>
	<43442D19.4050005@perkel.com>
	<Pine.LNX.4.58.0510052208130.4308@be1.lrz>
	<8qo997np4h6n.1ihs13ptrx2y2.dlg@40tude.net>
	<1128695400.28620.42.camel@icampbell-debian>
	<1128696194.31606.53.camel@tara.firmix.at>
X-Yow: Uh-oh --  WHY am I suddenly thinking of a VENERABLE religious leader
 frolicking on a FORT LAUDERDALE weekend?
Date: Fri, 07 Oct 2005 17:04:59 +0200
In-Reply-To: <1128696194.31606.53.camel@tara.firmix.at> (Bernd Petrovitsch's
	message of "Fri, 07 Oct 2005 16:43:14 +0200")
Message-ID: <jey855z7tw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> writes:

> On Fri, 2005-10-07 at 15:30 +0100, Ian Campbell wrote:
>> Access via /proc/PID/fd/* seems to work:
>> 
>> $ echo "Hello World" > testing
>> $ exec 10>>testing
>> $ rm testing
>> $ ls -l /proc/self/fd/
>> total 5
>> lrwx------  1 icampbell icampbell 64 Oct  7 15:28 0 -> /dev/pts/9
>> lrwx------  1 icampbell icampbell 64 Oct  7 15:28 1 -> /dev/pts/9
>> l-wx------  1 icampbell icampbell 64 Oct  7 15:28 10
>> -> /home/icampbell/testing (deleted)
>> lrwx------  1 icampbell icampbell 64 Oct  7 15:28 2 -> /dev/pts/9
>> lr-x------  1 icampbell icampbell 64 Oct  7 15:28 3 -> /proc/31390/fd/
>> $ cat /proc/self/fd/10
>> Hello World
>> $
>
> Did you try linking it?

link(2) does not follow symlinks, and there is no flink(2).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
