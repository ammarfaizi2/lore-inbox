Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263051AbVF3Ueq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbVF3Ueq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVF3UXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:23:13 -0400
Received: from ucsd-exchange.ucsd.edu ([132.239.1.171]:11518 "EHLO
	ono-exchange.ad.ucsd.edu") by vger.kernel.org with ESMTP
	id S263135AbVF3UIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:08:50 -0400
Subject: Re: reiser4 plugins
From: Kevin Bowen <kevin@ucsd.edu>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hubert Chan <hubert@uhoreg.ca>, Hans Reiser <reiser@namesys.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl>
References: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Jun 2005 13:08:42 -0700
Message-Id: <1120162123.22241.53.camel@punchline.ucsd.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> might be nice to have on exclusively one-user, isolated machines, like
> "keep /my/ annotations/icon/application name/whatever with the file's
> data", but that break down in multiuser (even serially, one user after the

If this is really the core of your (and the rest of the reiser-
obstructionist crowd's) objection to the file-as-directory concept, then
you just haven't thought it through thoroughly enough. Ignore for the
moment the case of system-wide or network-wide shared data, and think
about it just limited to a user's home directory, and the storage and
organization of actual *data* (as opposed to system files). The desire
amongst users for ubiquitous metadata is very real - the current wave of
"desktop search" products and technologies demonstrates this - but
search is really only the lowest-hanging fruit of this new way of
looking at data. Application-layer solutions like Beagle, Google Desktop
Search et al allow for querying on metadata, but actually *acting* on
the results of those queries requires that they be exposed via first
class primitives which can be manipulated with arbitrary tools, not via
some proprietary userland api which only one tool ever actually
implements. 

As to the case of system-wide shared files, there is already a mechanism
to prevent users from inappropriately annotating files that don't belong
to them: file permissions. If you're sysadmining a multiuser reiser4
box, and your users are able to modify the metadata of files they don't
own, then you go to sysadmin purgatory. 

> other way; OpenOffice /has/ structured files, XML inside zipped files,
Java
> also uses zip files for its structuring needs, etc), or are ideas that

And as a Java developer, I can tell you that the wide consensus is that
this solution is half-assed and insufficient for both developers and
users needs. In fact, I believe there is currently a JSR in progress to
develop a more sophisticated Java packaging model.

-- 
kevin@ucsd.edu
