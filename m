Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbWF0R7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWF0R7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWF0R7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:59:05 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:29456 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1161242AbWF0R7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:59:00 -0400
Message-ID: <20060627215859.A20679@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 21:58:59 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <m14py6ldlj.fsf@ebiederm.dsl.xmission.com>; from "Eric W. Biederman" on Tue, Jun 27, 2006 at 11:20:40AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

On Tue, Jun 27, 2006 at 11:20:40AM -0600, Eric W. Biederman wrote:
> 
> Thinking about this I am going to suggest a slightly different direction
> for get a patchset we can merge.
> 
> First we concentrate on the fundamentals.
> - How we mark a device as belonging to a specific network namespace.
> - How we mark a socket as belonging to a specific network namespace.

I agree with the direction of your thoughts.
I was trying to do a similar thing, define clear steps in network
namespace merging.

My first patchset covers devices but not sockets.
The only difference from what you're suggesting is ipv4 routing.
For me, it is not less important than devices and sockets.  May be even
more important, since routing exposes design deficiencies less obvious at
socket level.

> 
> As part of the fundamentals we add a patch to the generic socket code
> that by default will disable it for protocol families that do not indicate
> support for handling network namespaces, on a non-default network namespace.

Fine

Can you summarize you objections against my way of handling devices, please?
And what was the typo you referred to in your letter to Kirill Korotaev?

Regards
	Andrey
