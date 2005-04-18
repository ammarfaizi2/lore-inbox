Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVDRUkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVDRUkn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 16:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDRUkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 16:40:43 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:36992 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261164AbVDRUkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 16:40:35 -0400
Subject: Re: [PATCH 0/7] procfs privacy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Rik van Riel <riel@redhat.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1113855485.17341.130.camel@localhost.localdomain>
References: <1113849977.17341.68.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181526280.11251@chimarrao.boston.redhat.com>
	 <1113853561.17341.111.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0504181600480.11251@chimarrao.boston.redhat.com>
	 <1113855485.17341.130.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Organization: National Security Agency
Date: Mon, 18 Apr 2005 16:31:35 -0400
Message-Id: <1113856295.30865.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-14) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 22:18 +0200, Lorenzo Hernández García-Hierro
wrote:
> For this purpose I (re)submitted a patch originally made by Serge E.
> Hallyn that adds a hook in order to catch task lookups, thus, providing
> an easy way to handle and determine when a task can lookup'ed.
> 
> It's at:
> http://pearls.tuxedo-es.org/patches/lsm/lsm-task_lookup-hook.patch
> 
> vSecurity currently provides support for it (optional).
> 
> SELinux policy can handle in a much more fine-grained these
> restrictions, just that it's still something that not all people can
> deploy without some special effort and "tweak up" (if their system
> doesn't provide support for it, of course, currently Red Hat has done a
> great job in that terms).

To be precise, SELinux assigns security labels to /proc inodes
(/proc/pid inodes are labeled based on the associated task label, and
other /proc inodes are labeled based on the policy configuration), and
controls access based on the policy.  It can e.g. prevent a process in
one security domain from accessing anything under /proc/<pid> for a
process in a different domain, but not from seeing the top-level entry
in /proc itself (as it doesn't do any kind of directory filtering).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

