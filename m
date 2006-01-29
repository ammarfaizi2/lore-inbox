Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWA2Ng0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWA2Ng0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWA2Ng0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:36:26 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:18347 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750978AbWA2Ng0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:36:26 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the  thread_group_leader
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 29 Jan 2006 14:36:13 +0100
References: <5AeeD-7xb-7@gated-at.bofh.it> <5Aggm-1V6-3@gated-at.bofh.it> <5AhYT-4uR-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1F3Ciz-0000tq-Ro@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:

> If process id namespaces become a reality init stops being
> terribly special, and becomes something you may have several
> of running at any one time.  If one of those inits is compromised
> by a hostile user I having the whole system go down so we can
> avoid executing a cheap test sounds terribly wrong.  That is
> why I really care.

There are virtual environments like linux-vserver(.org), where init is
running several times on one system, each with their local/virtual
pid being 1. Killing them does no harm unless it's the real init.
I asume in your system,  the real init will exist under the control
of the administrator, too, so there should be no danger.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
