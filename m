Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422983AbWBOFzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422983AbWBOFzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422984AbWBOFzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:55:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422983AbWBOFzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:55:19 -0500
Date: Tue, 14 Feb 2006 21:54:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] Fix the comparison with sizeof()
Message-Id: <20060214215415.078e11de.akpm@osdl.org>
In-Reply-To: <s5h3bilbteq.wl%tiwai@suse.de>
References: <s5h3bilbteq.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
>  -		  min((unsigned int)scsicmd->cmnd[13], sizeof(cp)));
>  +		  min((size_t)scsicmd->cmnd[13], sizeof(cp)));

Note that this can also be done with the min_t() macro, although I can't
immediately think of a reason why min_t() is any better..
