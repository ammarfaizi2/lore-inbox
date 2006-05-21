Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWEUVav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWEUVav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWEUVau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 17:30:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48821 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964940AbWEUVau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 17:30:50 -0400
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
From: Lee Revell <rlrevell@joe-job.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <4470CC8F.9030706@keyaccess.nl>
References: <4470CC8F.9030706@keyaccess.nl>
Content-Type: text/plain
Date: Sun, 21 May 2006 17:30:46 -0400
Message-Id: <1148247047.20472.78.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 22:24 +0200, Rene Herman wrote:
> Hi list.
> 
> 2.6.17-rc2 (and 3 and 4) make my audio skip. Audio player is ogg123 
> running in an xterm. Browsing heavy sites (say, eBay) with Firefox 
> 1.5.0.3 gets me audio underruns quickly. This does not happen on 
> 2.6.17-rc1 and earlier (I just tested extensively; quite impossible to 
> generate underruns on -rc1, quickly on -rc2 and later).
> 
> It's not ALSA; reverted */sound/* from the rc1-rc2 interdiff. It's also 
> not cfq-iosched.c. Any likely culprits in there? (I'm not a GIT user).
> 

I would suspect the scheduler interactivity patches.  Please confirm
this by running ogg123 at nice -20 - do the underruns persist?

Lee

