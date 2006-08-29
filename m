Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965419AbWH2VWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965419AbWH2VWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965420AbWH2VWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 17:22:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:14723 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965419AbWH2VWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 17:22:34 -0400
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: kraxel@bytesex.org, Andrew Morton <akpm@osdl.org>, clg@fr.ibm.com,
       serue@us.ibm.com, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060829211555.GB1945@us.ibm.com>
References: <20060829211555.GB1945@us.ibm.com>
Content-Type: text/plain
Date: Tue, 29 Aug 2006 14:22:26 -0700
Message-Id: <1156886546.5408.191.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-29 at 14:15 -0700, Sukadev Bhattiprolu wrote:
> @@ -1004,15 +1002,16 @@ int saa7134_tvaudio_init2(struct saa7134
>  		break;
>  	}
>  
> -	dev->thread.pid = -1;
> +	dev->thread.task = NULL;
>  	if (my_thread) {
...

This is _really_ minor, but I think dev is kzmalloc()'d.  I haven't
examined it closely enough to tell if these devices get reused, but this
one _might_ be unnecessary.  Certainly no big deal either way, and it
certainly doesn't make anything worse.

-- Dave

