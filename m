Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWC1Wux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWC1Wux (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWC1Wux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:50:53 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:50829 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932491AbWC1Wuw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:50:52 -0500
Subject: Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, devel@openvz.org
In-Reply-To: <4428F902.1020706@sw.ru>
References: <44242A3F.1010307@sw.ru>
	 <20060324211917.GB22308@MAIL.13thfloor.at>
	 <m1psk7enfm.fsf@ebiederm.dsl.xmission.com>  <4428F902.1020706@sw.ru>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 10:51:03 +1200
Message-Id: <1143586264.6325.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 12:51 +0400, Kirill Korotaev wrote:
> we will create a separate branch also called -acked, where patches 
> agreed upon will go.

No need.  Just use Acked-By: comments.

Also, can I give some more feedback on the way you publish your patches:

 1. git's replication uses the notion of a forward-only commit list. 
    So, if you change patches or rebase them then you have to rewind
    the base point - which in pure git terms means create a new head.
    So, you should use the convention of putting some identifier - a
    date, or a version number - in each head.

 2. Why do you have a seperate repository for your normal openvz and the
    -ms trees?  You can just you different heads.

 3. Apache was doing something weird to the HEAD symlink in your
    repository.  (mind you, if you adopt notion 1., this becomes
    irrelevant :-))

Otherwise, it's a great thing to see your patches published via git!

I can't recommend Stacked Git more highly for performing the 'winding'
of the patch stack necessary for revising patches.  Google for "stgit".

Sam.

