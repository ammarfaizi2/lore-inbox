Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWATTy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWATTy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 14:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWATTy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 14:54:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19916 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932108AbWATTy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 14:54:28 -0500
To: linux-kernel@vger.kernel.org
Cc: "Alan Cox <alan@lxorguk.ukuu.org.uk> Dave Hansen" 
	<haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: RFC: Multiple instances of kernel namespaces.
References: <20060117143258.150807000@sergelap> <43CD18FF.4070006@FreeBSD.org>
	<1137517698.8091.29.camel@localhost.localdomain>
	<43CD32F0.9010506@FreeBSD.org>
	<1137521557.5526.18.camel@localhost.localdomain>
	<1137522550.14135.76.camel@localhost.localdomain>
	<1137610912.24321.50.camel@localhost.localdomain>
	<1137612537.3005.116.camel@laptopd505.fenrus.org>
	<1137613088.24321.60.camel@localhost.localdomain>
	<1137624867.1760.1.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 20 Jan 2006 12:53:16 -0700
In-Reply-To: <1137624867.1760.1.camel@localhost.localdomain> (Alan Cox's
 message of "Wed, 18 Jan 2006 22:54:27 +0000")
Message-ID: <m1bqy6oevn.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At this point I have to confess I have been working on something
similar, to IBM's pid virtualization work.  But I have what is at
least for me a unifying concept, that makes things easier to think
about.

The idea is to think about things in terms of namespaces.  Currently
in the kernel we have the fs/mount namespace already implemented.

Partly this helps on what the interface for creating a new namespace
instance should be.  'clone(CLONE_NEW<NAMESPACE_TYPE>)', and how
it should be managed from the kernel data structures.

Partly thinking of things as namespaces helps me scope the problem.

Does this sound like a sane approach?

Eric
