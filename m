Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWDGTVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWDGTVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWDGTVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:21:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58091 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964905AbWDGTU7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:20:59 -0400
Date: Fri, 7 Apr 2006 14:20:52 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, "Eric W. Biederman" <ebiederm@xmission.com>,
       xemul@sw.ru, James Morris <jmorris@namei.org>, serge@hallyn.com
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
Message-ID: <20060407192052.GB28729@sergelap.austin.ibm.com>
References: <20060407095132.455784000@sergelap> <20060407183600.C8A8F19B8FD@sergelap.hallyn.com> <20060407191359.GC9097@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407191359.GC9097@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Ravnborg (sam@ravnborg.org):
> On Fri, Apr 07, 2006 at 01:36:00PM -0500, Serge E. Hallyn wrote:
> > This patch defines the uts namespace and some manipulators.
> > Adds the uts namespace to task_struct, and initializes a
> > system-wide init namespace which will continue to be used when
> > it makes sense.
> It also kills system_utsname so you left the kernel uncompileable.
> Can you kill it later?

I can insert a #define system_utsname (init_uts_ns.name) in patch 1
and nuke it at patch 3.

-serge
