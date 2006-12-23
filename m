Return-Path: <linux-kernel-owner+w=401wt.eu-S1752910AbWLWOAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbWLWOAV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 09:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbWLWOAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 09:00:20 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:47790 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbWLWOAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 09:00:19 -0500
Date: Sat, 23 Dec 2006 15:00:18 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
In-Reply-To: <1166869106.3281.587.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> 
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>
  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If user (or script) doesn't specify that flag, it doesn't help. I think
>> the best solution for these filesystems would be either to add new syscall
>>  	int is_hardlink(char *filename1, char *filename2)
>> (but I know adding syscall bloat may be objectionable)
>
> it's also the wrong api; the filenames may have been changed under you
> just as you return from this call, so it really is a
> "was_hardlink_at_some_point()" as you specify it.
> If you make it work on fd's.. it has a chance at least.

Yes, but it doesn't matter --- if the tree changes under "cp -a" command, 
no one guarantees you what you get.
 	int fis_hardlink(int handle1, int handle 2);
Is another possibility but it can't detect hardlinked symlinks.

Mikulas
