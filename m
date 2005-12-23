Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030545AbVLWPfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030545AbVLWPfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbVLWPfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:35:07 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:51878 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030545AbVLWPfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:35:06 -0500
Message-ID: <43AC1942.2010707@tmr.com>
Date: Fri, 23 Dec 2005 10:35:30 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tetsuo Handa <from-kernelnewbies@I-love.sakura.ne.jp>
CC: arjan@infradead.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: [RFC] TOMOYO Linux released!
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>	<1135164793.3456.9.camel@laptopd505.fenrus.org>	<200512212112.HBH59669.FCNLMTFJFFSSPGtOOX@i-love.sakura.ne.jp>	<Pine.LNX.4.61L.0512221808160.6194@imladris.surriel.com> <200512231338.FBF16755.TJLXFMSNOGtFSFFCOP@I-love.sakura.ne.jp>
In-Reply-To: <200512231338.FBF16755.TJLXFMSNOGtFSFFCOP@I-love.sakura.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa wrote:
> Hello,
> 
> Rik van Riel wrote:
> 
>>Why does the Tomoyo patch have its own hooks in various
>>places sitting right next to the LSM hooks?
> 
> There are two reasons.
> 
> One is to support both 2.4 kernels and 2.6 kernels.
> 
> The other is some parameters are missing for TOMOYO Linux.
> TOMOYO needs "struct vfsmnt" parameter to calculate realpath(2),
> but this parameter is unavailable after entring into
> the vfs functions (for example, vfs_mknod()) and
> unable to use (for example, security_inode_mknod()).
> 
> Also not all hooks needed for TOMOYO Linux are provided by LSM.
> For example, a hook for SAKURA_MayAutobind() is not provided by LSM.
> 
> 
> 
> By the way, the kickstart guide is now available at
> http://tomoyo.sourceforge.jp/en/kickstart/ .
> 
> If you have private questions, you can send mails to
> tomoyo-support _at_ lists.sourceforge.jp .

Hopefully most questionss will stay here until people have a chance to 
get general questions answered. This is interesting stuff, although I 
suspect that the main goal was safe operation of authorized users on the 
machine, rather than protection of servers. It appears to have benefits 
for servers as well, of course.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
