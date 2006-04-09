Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWDIKPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWDIKPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 06:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDIKPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 06:15:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750718AbWDIKPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 06:15:00 -0400
Date: Sun, 9 Apr 2006 11:14:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [PATCH 3/7] uts namespaces: use init_utsname when appropriate
Message-ID: <20060409101436.GA20084@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
	Kirill Korotaev <dev@sw.ru>, herbert@13thfloor.at, devel@openvz.org,
	sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
References: <20060407234815.849357768@sergelap> <20060408045206.EAA8E19B8FF@sergelap.hallyn.com> <m1psjslf1s.fsf@ebiederm.dsl.xmission.com> <20060408202701.GA26403@sergelap.austin.ibm.com> <m164ljjd70.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164ljjd70.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 09, 2006 at 03:44:19AM -0600, Eric W. Biederman wrote:
> There are two ways to avoid the associated problems.
> - modify daemonize to always use the instance of that
>   namespace associated with init_task.
> - modify all interesting kernel threads to use the
>   kthread api instead of kernel_thread.  Using kthread
>   makes the kernel threads children of keventd and always
>   in the initial namespace instance.  As such we know
>   we aren't inside of any user space namespace instance.

I've added a deprecation entry for the kernel_thread export and plan
to convert all users to the kthread API.  Any help on that is of course
greatly appreciated.
