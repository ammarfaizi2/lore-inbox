Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbTLFPBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTLFPBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:01:24 -0500
Received: from main.gmane.org ([80.91.224.249]:52428 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265181AbTLFPBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:01:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [OT] Rootkit queston
Date: Sat, 06 Dec 2003 16:01:20 +0100
Message-ID: <yw1x65gu7zy7.fsf@kth.se>
References: <874qwehxf1.wl@drakkar.ibe.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:xD6BqOL/poeAIGYs7dqrVH60wLk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samium Gromoff <deepfire@ibe.miee.ru> writes:

>> You can check for a common 'root attack', if you have inetd,
>> by looking at the last few lines in /etc/inetd.conf.
>> It may have some access port added that allows anybody
>> who knows about it to log in as root from the network.
>> It will look something like this:
>>
>> # End of inetd.conf.
>> 4002 stream tcp nowait root /bin/bash --
>>
>> In this case, port 4002 will allow access to a root shell
>> that has no terminal processing, but an attacker can use this
>> to get complete control of your system. FYI, this is a 5-year-old
>> attack, long obsolete if you have a "store-bought" distribution
>> more recent.
>
> How is it an attack?
> 	(in order to write to inetd.conf you need to be root already)
>
> And if it is, what does it accomplish?
> 	(writing a daemon listening on a $BELOVED_PORT port is trivial)

Suppose you found a bug in a web server that would make the server
append arbitrary data to existing files.  Adding that line to
inetd.conf would be one way to use that bug to gain full control over
the machine.

-- 
Måns Rullgård
mru@kth.se

