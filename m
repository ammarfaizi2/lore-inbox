Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVEFNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVEFNxE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEFNw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:52:58 -0400
Received: from [213.170.72.194] ([213.170.72.194]:60902 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261225AbVEFNwo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:52:44 -0400
Subject: Re: [PATCH] __wait_on_freeing_inode fix
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, dwmw2@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: MTD
Date: Fri, 06 May 2005 17:52:42 +0400
Message-Id: <1115387562.27158.39.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Compile tested only.  This condition is very hard to trigger normally
> (simultaneous clear_inode() with iget()) so probably only heavy stress
> testing can reveal any change of behavior.

Well, my stress test works fine with your patch. I've tested it on JFFS2
FS which works on top of RAM-emulated flash. I tried it together with my
patch since otherwise the stress test crashes due to the race that my
patch fixes.

On vanilla linux-2.6.11.5 the stress test usually crashes in about 5
minutes, but linux-2.6.11.5 + the 2 patches (as well as + only one my
patch) it is stable for 2 hours already.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

