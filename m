Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280684AbRKFXG6>; Tue, 6 Nov 2001 18:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280672AbRKFXGs>; Tue, 6 Nov 2001 18:06:48 -0500
Received: from jalon.able.es ([212.97.163.2]:45739 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S280704AbRKFXGh>;
	Tue, 6 Nov 2001 18:06:37 -0500
Date: Tue, 6 Nov 2001 23:53:03 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: erik@hensema.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011106235303.A6661@werewolf.able.es>
In-Reply-To: <20011105144112.Q11619@pasky.ji.cz> <4.3.2.7.2.20011106093248.00bea990@10.1.1.42> <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl>; from spamtrap@use.reply-to on Tue, Nov 06, 2001 at 21:12:32 +0100
X-Mailer: Balsa 1.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011106 Erik Hensema wrote:
>Stephen Satchell (satch@concentric.net) wrote:
>>The RIGHT tool to fix the problem is the pen, not the coding pad.  I
>>hereby pick up that pen and put forth version 0.0.0.0.0.0.0.0.1 of the
>>Rules of /Proc:
>
>Agreed.
>
>>
>>7)  The /proc data may include comments.  Comments start when an  unescaped 
>>hash character "#" is seen, and end at the next newline \n.  Comments may 
>>appear on a line of data, and the unescaped # shall be treated as end of 
>>data for that line.
>

Well, perhaps this is a stupid idea. But I throw it.
ASCII is good for humans, bin is good to read all info easily in a program.
Lets have both.

Once I thought the solution could be to make /proc entries behave
differently in two scenarios. Lets suppose you could open files in ASCII
or binary mode. An entry opened in ASCII returns printable info and opened
in binary does the binay output. As there is no concept of ASCII or binary
files in low-level file management, the O_DIRECT flag (or any new flag) could
be used.

And (supposing all fies in /proc are 0-sized) perhaps a seek position could be
defined for reading a format string or a set of field names, ie:
lseek(SEEK_FORMAT); read(...);

Same for writing, opening in "wa" allows to write a formatted number (ie,
echo 0xFF42 > /proc/the/fd) and  "wb" allows to write binary data
(write("/proc/the/fd",&myValue)).

Just an idea...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-beo #1 SMP Tue Nov 6 16:23:01 CET 2001 i686
