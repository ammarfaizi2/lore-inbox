Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWE3JMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWE3JMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWE3JMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:12:12 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:9931 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932200AbWE3JML
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 30 May 2006 05:12:11 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17532.2897.90009.363261@gargle.gargle.HOWL>
Date: Tue, 30 May 2006 13:07:29 +0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [patch 25/61] lock validator: design docs
Newsgroups: gmane.linux.kernel
In-Reply-To: <20060529212514.GY3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212514.GY3155@elte.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > From: Ingo Molnar <mingo@elte.hu>

[...]

 > +
 > +enum bdev_bd_mutex_lock_type
 > +{
 > +       BD_MUTEX_NORMAL,
 > +       BD_MUTEX_WHOLE,
 > +       BD_MUTEX_PARTITION
 > +};

In some situations well-defined and finite set of "nesting levels" does
not exist. For example, if one has a tree with per-node locking, and
algorithms acquire multiple node locks left-to-right in the tree
order. Reiser4 does this.

Can nested locking restrictions be weakened for certain lock types?

Nikita.
