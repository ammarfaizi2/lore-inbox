Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129258AbRBSC4m>; Sun, 18 Feb 2001 21:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129440AbRBSC4d>; Sun, 18 Feb 2001 21:56:33 -0500
Received: from adsl-64-163-64-74.dsl.snfc21.pacbell.net ([64.163.64.74]:41220
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S129258AbRBSC4X>; Sun, 18 Feb 2001 21:56:23 -0500
Message-Id: <200102190256.f1J2uIs23040@konerding.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4 
In-Reply-To: Your message of "Mon, 19 Feb 2001 11:37:54 +1100."
             <14992.27362.114723.93990@notabene.cse.unsw.edu.au> 
Date: Sun, 18 Feb 2001 18:56:18 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
>On Sunday February 18, dek_ml@konerding.com wrote:
>> 
>> Hi,
>> 
>> I migrated some exported disks over to reiserfs and had no luck when I
>> mounted the disk via NFS on another machine.  I've noticed many messages
>> about reiser and NFS in the archives, but my understanding was that
>> it had been cleared up.  In particular, the Configure.help in 2.4.2-pre4
>> says "reiserfs can be used for anything that ext2 can be used for".
>
>
>If you go to
>
>  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2-pre3/
>
>and pick up patch-B-nfsdops and patch-C-reisernfs
>you should get reasonable nfs service for reiserfs.
>Note that this is not final code though.  The format of the filehandle
>will probably change shortly as it doesn't currently contain a
>generation number.
>A similar patch is available somewhere under www.namesys.com I
>believe.

OK, I grabbed these patches and applied them against 2.4.2-pre4 and
recompiled, rebooted.  I am now able to use reiserfs with NFS,
basic operations appear to work as expected but I haven't done large amounts
of file IO or lots of concurrent requests.  

What is the plan with regards to these patches, or ones like it, making it into
the distribution?  I noticedAlan Cox just posted the following:

>The configure.help is wrong on that and one other thing. NFS doesnt work
>without extra patches and big endian boxes dont work with reiserfs currently
>Chris - would it be worth sending me a patch that notes the NFS thing in
>Configure.help and includes the patch url ?

which suggests that the Configure.help mis-statement is going to be corrected but
doesn't imply the fix is going in any time soon.  I think NFS over Reiser is going
to be interesting to people who are running big fileservers, so if this patch
really does fix it (without breaking anything else) then itwould make sense for it
to go in.

Dave
