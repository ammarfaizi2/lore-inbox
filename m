Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUAZGJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbUAZGJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:09:42 -0500
Received: from dp.samba.org ([66.70.73.150]:5000 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265546AbUAZGJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:09:41 -0500
Date: Mon, 26 Jan 2004 17:05:55 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with module-init-tools
Message-Id: <20040126170555.7ca722fc.rusty@rustcorp.com.au>
In-Reply-To: <20040124222907.GA4072@werewolf.able.es>
References: <20040124222907.GA4072@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004 23:29:07 +0100
"J.A. Magallon" <jamagallon@able.es> wrote:

> Hi all...
> 
> I have a problem with modprobe, 2.6.2-rc1-mm2, and agpgart.
> 
> With 2.4, I had this setup to have agpgart loaded:
> 
> alias char-major-226 agpgart

The new style is "alias char-major-226-* agpgart", but that should still
work in 2.6.2-rc1.

> With 2.6 and the same setup, that module is loaded. But as agpgart backend is
> now split, I need to load also intel-agp.ko. I read manuals, and corrected my
> modprobe.conf this way:
> 
> install agpgart /sbin/modprobe intel-agp; /sbin/modprobe --ignore-install agpgart;

Yes.  intel-agp presumably depends on agpgart?  If so,
(1) You can just alias char-major-226 intel-agp
(2) There was a bug some older module-init-tools versions, have you tried
	3.0-pre7?

Thanks!
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
