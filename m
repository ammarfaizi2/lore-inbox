Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266513AbUIAB1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266513AbUIAB1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUIAB1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:27:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25732 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266513AbUIAB11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:27:27 -0400
Subject: Re: [DOC] Linux kernel patch submission format
From: Lee Revell <rlrevell@joe-job.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>,
       rgooch@atnf.csiro.au
In-Reply-To: <1093972632.6200.50.camel@localhost.localdomain>
References: <413431F5.9000704@pobox.com>
	 <1093970261.6200.45.camel@localhost.localdomain>
	 <4134B221.9070203@pobox.com>
	 <1093972632.6200.50.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1094002047.3404.40.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 31 Aug 2004 21:27:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 13:17, David Woodhouse wrote:
> On Tue, 2004-08-31 at 13:15 -0400, Jeff Garzik wrote:
> > hmmmm.  While I do agree with the content, I'm trying to avoid 
> > lengthening this page.  If we describe every little detail, then it 
> > becomes long -- just like SubmittingPatches -- and everybody will skip 
> > reading it.
> 
> Good point. How about cutting it down to this then:
> 
> --- patch-format.html.orig      2004-08-31 17:30:55.867029816 +0100
> +++ patch-format.html   2004-08-31 18:16:14.042804288 +0100
> @@ -81,7 +81,9 @@
> 
>  This cannot be stressed enough.  Even when you are resending a change
>  for the 5th time, resist the urge to attach 20 patches to a single
> -email.
> +email. If you do send multiple emails though, make sure the second
> +and subsequent emails are sent as replies to the first, to keep them
> +all together in a thread.
> 
>  </li><li><h2>Sign your work</h2>
> 

This patch updates the FAQ to match the preferred method for submitting
large patches.  Rather than repeating the redundant paragraph, I removed
it.  Also Andrew Morton should really get credit for this entry, but he
is not in the Contributors list.

--- LKML_FAQ.htm	2004-08-31 19:18:45.000000000 -0400
+++ LKML_FAQupdated.htm	2004-08-31 21:23:31.000000000 -0400
@@ -1723,10 +1723,14 @@
 read your patch, and thus your patch will be deleted without comment.
 </LI>
 <LI>
-If you have a large patch, post a URL instead, otherwise you'll fill
-the mailboxes of thousands of people, and you will get complaints.
-Posting a new, large patch once might be OK, but updates should not be
-posted in full (post a URL).
+This FAQ previously advised posting a URL to a patch if the patch is large.
+This is no longer recommended.  The preferred way to submit a large patch is to 
+break it up into logical chunks, with a descriptive comment for each, and post 
+each piece with a subject line like "[PATCH] cleanup of foo driver [1/5]".
+Do not start a new thread for each chunk - rather, post each chunk as a followup 
+to the previous chunk.  You may want to begin with an explanatory post, and label 
+it something like "[PATCH] cleanup of foo driver [0/5]".  See 
+Documentation/SubmittingPatches for more information.
 </LI>
 <LI>
 If you want Linus or one of the primary maintainers (i.e. Marcelo,
@@ -3609,14 +3613,6 @@
 </LI>
 
 <LI>
-<FONT COLOR="#0000FF">(PG)</FONT> If your patch is on the large size
-(say larger than 500 lines) consider posting a URL pointing to the
-patch along with the patch description, instead of the whole patch. If
-you don't have a WWW site handy to put the patch on, then at least
-gzip it prior to attaching it to your post/patch description.
-</LI>
-
-<LI>
 <FONT COLOR="#0000FF">(REG)</FONT> Note that Linus does not read
 linux-kernel very much. So if you want him to see a patch, you will
 need to send it to him directly (say by Cc:ing him if you post to the

Lee

