Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVBVWIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVBVWIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVBVWIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:08:19 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64456 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261291AbVBVWIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:08:13 -0500
Subject: Re: reading the same entropy twice
From: Lee Revell <rlrevell@joe-job.com>
To: "Bob O'Neill" <rmoneill@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4b325ef050222135529a2584a@mail.gmail.com>
References: <4b325ef050222135529a2584a@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 17:08:11 -0500
Message-Id: <1109110092.31071.47.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-22 at 16:55 -0500, Bob O'Neill wrote:
> Hello.
> 
> I have noticed that it is possible on an SMP box for two processes to
> simultaneously read the same entropy out of /dev/urandom.  This
> doesn't seem right to me.  I was using the entropy value to generate a
> random number to use as a session ID, so occasionally there would be a
> collision on session IDs, causing a login failure as session IDs are
> required to be unique.  This issue does not appear to be related to
> entropy depletion.
> 
> Could you provide me with some insight into why this is the case, if
> it is intentional?  It seems like it could be addressed with a
> spinlock.

Please check the LKML archives, this was debated at length last month
IIRC.  I don't recall whether it ended conclusivelty.

Lee

