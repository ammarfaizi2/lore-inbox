Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWEVQ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWEVQ4I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEVQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:56:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1251 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750988AbWEVQ4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:56:07 -0400
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       serue@us.ibm.com, linux-kernel@vger.kernel.org, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com
Subject: Re: [PATCH 0/9] namespaces: Introduction
References: <20060518154700.GA28344@sergelap.austin.ibm.com>
	<20060518103430.080e3523.akpm@osdl.org>
	<20060519124235.GA32304@MAIL.13thfloor.at>
	<20060519081334.06ce452d.akpm@osdl.org>
	<20060521225735.GA9048@elf.ucw.cz>
	<m1ejynnezp.fsf@ebiederm.dsl.xmission.com>
	<20060521233215.GA15353@MAIL.13thfloor.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 May 2006 10:54:11 -0600
In-Reply-To: <20060521233215.GA15353@MAIL.13thfloor.at> (Herbert Poetzl's
 message of "Mon, 22 May 2006 01:32:15 +0200")
Message-ID: <m1sln2knkc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep.  I bungle my description pretty badly.

The key points.
-  Simply messing with pid == 1 is not enough, you need to filter
   which pids are accessible.
-  pid isolation by permission checks and pid isolation via
   pid visibility are competing implementations.
-  pid isolation by permission checks (except for the pid == 1 case)
   can currently be implemented with a security module.
   
Eric
