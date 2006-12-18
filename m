Return-Path: <linux-kernel-owner+w=401wt.eu-S1753552AbWLRJAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbWLRJAT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbWLRJAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:00:19 -0500
Received: from smtp20.orange.fr ([193.252.22.31]:38349 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552AbWLRJAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:00:18 -0500
X-Greylist: delayed 3382 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 04:00:18 EST
X-ME-UUID: 20061218080353379.5C8041C000DA@mwinf2019.orange.fr
Message-ID: <45864B68.2030306@free.fr>
Date: Mon, 18 Dec 2006 09:03:52 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.7) Gecko/20060405 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Damien Wyart <damien.wyart@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc1-mm1
References: <20061214225913.3338f677.akpm@osdl.org> <20061215203936.GA2202@localhost.localdomain> <20061215130141.fd6a0c25.akpm@osdl.org> <20061217110710.GA1994@localhost.localdomain>
In-Reply-To: <20061217110710.GA1994@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17.12.2006 12:07, Damien Wyart a écrit :
>>> Also, I got panics when unmounting reiser4 filesystems with
>>> 2.6.20-rc1-mm1 but I guess this is related to your waring about
>>> reiser4 being broken in 2.6.19-mm1 (even if it is not listed in
>>> notes for 2.6.20-rc1-mm1)... I attach dmesg and config, but the
>>> reiser4 panics did not get logged and I am not able to reboot on
>>> 2.6.20-rc1-mm1 right now. For the moment, I mainly wanted to report
>>> the xfs messages which seems a bit suspect.
> 
>> The reiser4 failure is unexpected. Could you please see if you can
>> capture a trace, let the people at reiserfs-dev@namesys.com know?
> 
> Ok, I've handwritten the messages, here they are :
> 
> reiser4 panicked cowardly : reiser4[umount(2451)] : commit_current_atom (fs/reiser4/txmngr.c:1087) (zam-597)
> write log failed (-5)
> 
> [ got 2 copies of them because I have 2 reiser4 fs)
> 
> I got them mainly when I try to reboot or halt the machine, and the
> process doesn't finish, the computer gets stuck after the reiser4
> messages. This is only with 2.6.20-mm1, not 2.6.19-rc6-mm2.
> 

fix-sense-key-medium-error-processing-and-retry.patch seems to be the culprit.

Reverting it fix those reiser4 panics for me. Damien, could you confirm please ?

~~
laurent
