Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUDIBqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 21:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDIBqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 21:46:52 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:46472 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S261500AbUDIBqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 21:46:50 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: setgid - its current use
Date: Thu, 8 Apr 2004 21:46:26 -0400
User-Agent: KMail/1.6.1
References: <1081446055.1587.172.camel@cube>
In-Reply-To: <1081446055.1587.172.camel@cube>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404082146.26103.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think you need user-private groups and setgid directories.
>
> First of all, ensure that each user has a group of
> their own. Do NOT put all users into a "users" group.
> So user "gami" would be in group "gami", or maybe
> a "gami_group" group if you prefer. Have the home
> directories owned by these groups.
>
> Second, set the umask to allow group write access.
> (this is why you need the user-private groups)
>
> Now suppose you have two users, bill and tom,
> who need to work together on the spamming project.
> Create a group called "spamming". Create a project
> directory /projects/spamming owned by root and
> in the spamming group. Make this directory setgid
> and group writable. Any files created in this
> directory will be owned by the spamming group.
> Due to the umask setting, permissions on these
> new files will allow access by all group members.
> The setgid bit will propagate to any newly created
> directories, but not to newly created files.
>

that must be the fine-grained control _i_ was after!! thank you... and we 
thought mandrake was a little stupid for doing new users that way... neural 
oops 

-- 
Rob Couto [rpc@cafe4111.org]
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--
