Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVFPTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVFPTNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVFPTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 15:13:22 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:51593 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261794AbVFPTNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 15:13:12 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <42B1CE12.3090803@namesys.com>
Date: Thu, 16 Jun 2005 12:08:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <42B091E3.3010908@namesys.com> <20050615225322.GB8584@thunk.org>
In-Reply-To: <20050615225322.GB8584@thunk.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>
> It's better to
>have a separate, out-of-band notification scheme --- it's what dbus is
>really designed to be for.
>  
>
If I understand you, you are saying don't change how we notify the app,
change how we notify the user and if it is the user that needs to act
then we should sidestep the app entirely by creating a new method that
talks to the user, including popping up a window if the user is using a
GUI, and doing some other configurable thing for other circumstances. 
We could even create a mapping of errors to what the system should do in
response to them that the user can modify for the rare case that they
care to.  Ok, I agree.

>  
>
>>>Also, there is not neccesarily one right answer to how to respond to a
>>>underlying I/O error in the filesystem.  So for ext2/3 filesystem, it
>>>is configurable.  
>>> 
>>>
>>>      
>>>
>>Perhaps these policy choices should be mount options, what do you think?
>>    
>>
>
>We put these policy options as options in the superblock, but there
>are some advantages in being able to override them at mount-time with
>mount options.  For example, one such advantage is that we can
>standardize them across different filesystems.
>
>However, even if we do have standardized mount options, it is a real
>pain to have to type a very long mount option when doing manual
>mounts.  So having defaults that can be stored in the superblock seems
>to be a good idea, in my opinion.
>  
>
agreed.

>						- Ted
>
>
>  
>

