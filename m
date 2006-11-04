Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965604AbWKDSwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965604AbWKDSwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965605AbWKDSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:52:20 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:7848 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965604AbWKDSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:52:19 -0500
Date: Sat, 4 Nov 2006 19:52:18 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: dean gaudet <dean@arctic.org>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0611041950470.24713@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.64.0611031057410.26057@twinlark.arctic.org>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If it overflows, it increases crash count instead. So really you have 2^47
>> transactions or 65536 crashes and 2^31 transactions between each crash.
>
> it seems to me that you only need to be able to represent a range of the
> most recent 65536 crashes... and could have an online process which goes
> about "refreshing" old objects to move them forward to the most recent
> crash state.  as long as you know the minimm on-disk crash count you can
> use it as an offset.

After 65536 crashes you have to run spadfsck --reset-crash-counts. Maybe I 
add that functionality to kernel driver too, so that it will be formally 
corect.

Mikulas

> -dean
>
> p.s. i could see a network device with spotty connectivity causing a large
> bump in crash count in a short period of time.
>
