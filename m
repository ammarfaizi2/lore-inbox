Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUHRM3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUHRM3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 08:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUHRM3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:29:39 -0400
Received: from [144.51.25.10] ([144.51.25.10]:30339 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S266181AbUHRM0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:26:14 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Paul Fulghum <paulkf@microgate.com>
Cc: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <412271EF.6040201@microgate.com>
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412271EF.6040201@microgate.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1092831738.26566.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 18 Aug 2004 08:22:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 17:00, Paul Fulghum wrote:
> Stephen, James, Andrew:
> 
> the selinux-revalidate-access-to-controlling-tty patch
> seems to be causing the problem with less program as
> shown above. See the rest of this thread for more details.

I find that puzzling, given that flush_unauthorized_files is only called
if the process is changing SIDs on exec, and running less certainly
doesn't involve a SID transition (at least for any policy that I have
seen).  I tried the sequence shown with 2.6.8.1-mm1 with SELinux enabled
and disabled, and did not see the behavior he describes.  Is the bug
reproducible?  Was he running with SELinux enabled or disabled?  What
policy did he have loaded?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

