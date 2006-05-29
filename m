Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWE2E7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWE2E7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWE2E7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:59:35 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:42894 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751178AbWE2E7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:59:34 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for atkbd.c from Ubuntu
Date: Mon, 29 May 2006 00:59:31 -0400
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060524113139.e457d3a8.zaitcev@redhat.com>
In-Reply-To: <20060524113139.e457d3a8.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605290059.32302.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 May 2006 14:31, Pete Zaitcev wrote:
> Hi, Dmitry:
> 
> What do you think about the attached? Apparently, this is needed to
> support Korean input keys. Please let me know if this can be included.
> 
> Here's a bug entry for reference:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=192637
>

Hi Pete,

Please look here:

	http://bugzilla.kernel.org/show_bug.cgi?id=2817#c4

"I will not accept this patch (or any similar patch) to extend the atkbd.c
mapping table - only standard scancodes are allowed there. The table is
easily modified from userspace, and that is the way to go.

In the past I tried to fill the table with all the entries, but found out
that there are two or three keyboards competing for every position in the
scancode table, with a different keycode."

I continue to agree with Vojtech's position here. Because kernel does not
have ability to detect the kind of keyboard connected to a box (nor do we
really want to store all this data in the kernel) all fine tuning of AT
keymap should be done from userspace.

-- 
Dmitry
