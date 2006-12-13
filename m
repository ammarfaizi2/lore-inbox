Return-Path: <linux-kernel-owner+w=401wt.eu-S932595AbWLMLEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932595AbWLMLEX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWLMLEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:04:23 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:56651 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932595AbWLMLEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:04:22 -0500
Date: Wed, 13 Dec 2006 12:03:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: get device from file struct
In-Reply-To: <1166006239.30185.66.camel@ThinkPadCK6>
Message-ID: <Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
References: <1165850548.30185.18.camel@ThinkPadCK6>  <457DA4A0.4060108@ens-lyon.org>
 <1165914248.30185.41.camel@ThinkPadCK6>  <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
 <1166006239.30185.66.camel@ThinkPadCK6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >thanks for the reply, the block device can be determined with the major
>> >and minor numbers , what I would be more interested in is if one can get
>> >the net_device struct from the file struct
>> 
>> Just how are you supposed to match files and network devices?
>> 
>
>from the struct file you can get the struct socket and from there to the
>struct sock .

That only applies when using PF_LOCAL sockets.

>What I would like to find out is where the data is coming
>from (read) and where it is going to(write) or if it is even possible to
>find the net device out using the struct file.

I really don't get what you want.

Suppose a daemon reads from a socket (PF_INET), then there is a file descriptor
to sockfs (look into /proc/$$/fd/). Well, then you may be able to get the
struct file for that socket, but it does not connect to a regular file
(S_IFREG) at all.


	-`J'
-- 
