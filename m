Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUHCVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUHCVCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHCVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 17:02:47 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:8965 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S266839AbUHCVCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 17:02:40 -0400
Date: Wed, 4 Aug 2004 01:02:39 +0400
From: Alexander Lyamin <flx@msu.ru>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Hans Reiser <reiser@namesys.com>, andrea@cpushare.com,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re:  secure computing for 2.6.7
Message-ID: <20040803210239.GB7236@alias.nmd.msu.ru>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Stephen Smalley <sds@epoch.ncsc.mil>,
	Hans Reiser <reiser@namesys.com>, andrea@cpushare.com,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20040704173903.GE7281@dualathlon.random> <40EC4E96.9090800@namesys.com> <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
X-Operating-System: Linux 2.6.5-7.95-bigsmp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Aug 03, 2004 at 08:40:45AM -0400, Stephen Smalley wrote:
> On Wed, 2004-07-07 at 15:27, Hans Reiser wrote:
> > Am I right to think that this could complement nicely our plans 
> > described at www.namesys.com/blackbox_security.html
> Hi Hans,
> 
> Out of curiosity, what do you think that this proposal will achieve that
> cannot already be done via SELinux policy?  SELinux policy can already
> express access rules based not only on the executable and user, but even
> the entire call chain that led to a given executable.

convinience ? speed ?


RBAC is a Good Thing, but I wonder if it could provide throughout syntax analysis
for vfs related syscalls. As it is now.

At least what declared in their docs, fs-wise they are somewhat like this

Macro Name	Description
stat_file_perms	Permissions to call stat or access on a file.
x_file_perms	Permissions to execute a file.
r_file_perms	Permissions to read a file.
rx_file_perms	Permissions to read and execute a file.
rw_file_perms	Permissions to read and write a file.
ra_file_perms	Permissions to read and append to a file.
link_file_perms	Permissions to link, unlink, or rename a file.
create_file_perms	Permissions to create, access, and delete a file.
r_dir_perms	Permissions to read and search a directory.
rw_dir_perms	Permissions to read and modify a directory.
ra_dir_perms	Permissions to read and add entries to a directory.
create_dir_perms	Permissions to create, access, and delete a directory.
mount_fs_perms	Permissions to mount and unmount a filesystem.


*shrugs*
Well, I am probably wrong...

p.s. _AND_ if I remember correctly reiser4 supposed to provide finer-then-file grain security.
well, at least it easily could, being truly semantic-enabled fs.

-- 
"the liberation loophole will make it clear.."
lex lyamin
