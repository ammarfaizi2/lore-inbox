Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVBBOeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVBBOeB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 09:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVBBOeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 09:34:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64492 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262382AbVBBOdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 09:33:52 -0500
To: Koichi Suzuki <koichi@intellilink.co.jp>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based	crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
	<41FF381B.4080904@intellilink.co.jp>
	<m1fz0gbqe5.fsf@ebiederm.dsl.xmission.com>
	<42009874.7000209@intellilink.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 07:31:52 -0700
In-Reply-To: <42009874.7000209@intellilink.co.jp>
Message-ID: <m1lla79go7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koichi Suzuki <koichi@intellilink.co.jp> writes:

> I meant with kexec and dump hook, there could be many more things can be done in
> addition to full core dump.  Initiating failover to other node will be one
> example.   Starting with this hook, there must be many good ideas.   So my idea
> is to make this hook general purpose, not for specific core dump tool.

Again that is what is has been implemented.  A fully stand alone executable
that lives in an independent and reserved address in memory is jumped
to.

The goal in the generic kernel is to keep the code path to do that
as small and as simple as possible to reduce the chances of it being
mis-implemented, or the chances of attempting to use corrupted kernel
functionality.

Eric
