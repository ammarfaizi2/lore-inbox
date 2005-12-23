Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVLWEid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVLWEid (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 23:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVLWEid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 23:38:33 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:20956 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S1030400AbVLWEic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 23:38:32 -0500
To: riel@surriel.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: [RFC] TOMOYO Linux released!
From: Tetsuo Handa <from-kernelnewbies@I-love.sakura.ne.jp>
References: <200512212020.FBF94703.XOTMFStFPCJNSFLFOG@I-love.SAKURA.ne.jp>
	<1135164793.3456.9.camel@laptopd505.fenrus.org>
	<200512212112.HBH59669.FCNLMTFJFFSSPGtOOX@i-love.sakura.ne.jp>
	<Pine.LNX.4.61L.0512221808160.6194@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.61L.0512221808160.6194@imladris.surriel.com>
Message-Id: <200512231338.FBF16755.TJLXFMSNOGtFSFFCOP@I-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Fri, 23 Dec 2005 13:38:11 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Rik van Riel wrote:
> Why does the Tomoyo patch have its own hooks in various
> places sitting right next to the LSM hooks?
There are two reasons.

One is to support both 2.4 kernels and 2.6 kernels.

The other is some parameters are missing for TOMOYO Linux.
TOMOYO needs "struct vfsmnt" parameter to calculate realpath(2),
but this parameter is unavailable after entring into
the vfs functions (for example, vfs_mknod()) and
unable to use (for example, security_inode_mknod()).

Also not all hooks needed for TOMOYO Linux are provided by LSM.
For example, a hook for SAKURA_MayAutobind() is not provided by LSM.



By the way, the kickstart guide is now available at
http://tomoyo.sourceforge.jp/en/kickstart/ .

If you have private questions, you can send mails to
tomoyo-support _at_ lists.sourceforge.jp .

Regards...
