Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVIUIwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVIUIwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 04:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIUIwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 04:52:32 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:16770 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750774AbVIUIwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 04:52:32 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>
Subject: Re: one more oops on sensor modules removal
Date: Wed, 21 Sep 2005 18:52:06 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <u562j19ssinm946odbib7lqfrij1hm8dst@4ax.com>
References: <20050916022319.12bf53f3.akpm@osdl.org> <20050921004230.64ed395d@werewolf.able.es> <20050920225647.167325f7.akpm@osdl.org>
In-Reply-To: <20050920225647.167325f7.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005 22:56:47 -0700, Andrew Morton <akpm@osdl.org> wrote:
>
>Is 2.6.14-rc2 OK?

It is here :o)

In one terminal:
  'while [ 1 ]; do sensors; done', 

in another:
  'while [ 1 ]; do rmmod w83627hf; sleep 1; modprobe w83627hf; sleep 1; done'


Is fine in -rc2, but same test on 2.6.14-rc1 locked up with a busy error 
a couple times on rmmod during ~ 30 seconds or so, something has changed 
and improved.

Grant.
