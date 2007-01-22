Return-Path: <linux-kernel-owner+w=401wt.eu-S1751603AbXAVKtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbXAVKtx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbXAVKtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:49:53 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:46636 "EHLO
	relay01.mail-hub.dodo.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbXAVKtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:49:52 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Santiago Garcia Mantinan <manty@debian.org>
Cc: Willy Tarreau <w@1wt.eu>, Santiago Garcia Mantinan <manty@debian.org>,
       Grant Coady <gcoady.lk@gmail.com>, dann frazier <dannf@dannf.org>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Date: Mon, 22 Jan 2007 21:49:50 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <ti59r21s1r87qtd854d6keiakr34donbcq@4ax.com>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo> <20070120010544.GY26210@colo> <t1r7r2thimh3gpuhtfc9l3aehjdd6dqkp8@4ax.com> <20070121230321.GC2480@1wt.eu> <20070122085400.GA16302@clandestino.aytolacoruna.es> <20070122091816.GA5144@1wt.eu> <20070122093630.GA20431@clandestino.aytolacoruna.es>
In-Reply-To: <20070122093630.GA20431@clandestino.aytolacoruna.es>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2007 10:36:30 +0100, Santiago Garcia Mantinan <manty@debian.org> wrote:

>> > As you can see I now can see the symbolic links perfectly and they work as
>> > expected.
>> > 
>> > In fact, this patch is working so well that it poses a security risk, as now
>> > the devices on my /mnt/dev directory are not only seen as devices (like they
>> > were seen on 2.4.33) but they also work (which didn't happen on 2.4.33).
>> 
>> Why do you consider this a security problem ? Is any user able to create a
>> device entry with enough permissions ? As a general rule of thumb, networked
>> file systems should be mounted with the "nodev" option.
>
>You are completely right on that, it is just that I thought those devices
>didn't work on 2.4.33, but I just retested again and they work ok, only that
>they were not working to me on the PC I tested the other day and it was
>because of a nodev option :-) just that.
>
>So... I have finised with my tests, I have tested an x86 client on which it
>worked ok, just like on the PowerPC client, both working perfectly just like
>they used to do on 2.4.33.
>
>> Grant, just to be sure, are you really certain that you tried the fixed kernel ?
>> It is possible that you booted a wrong kernel during one of your tests. I'm
>> intrigued by the fact that it changed nothing for you and that it fixed the
>> problem for Santiago.
>
>Maybe he had also applied some of the earlier patches you had sent and that
>I did not apply to mine?
>
>Just to clear things up a bit, I'm sure I'm with the 2.4.34 kernel and...
>I'm running a pristine kernel with just this latest patch applied, the one
>that changes S_IFREG for (fattr->f_mode & S_IFMT).

Same kernel + patch here for latest results posting :)  We seem to get 
similar results now -- though I query the file execute bits coming up.

Grant.
>
>Regards...

