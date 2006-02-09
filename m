Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWBISHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWBISHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWBISHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:07:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932516AbWBISHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:07:34 -0500
Date: Thu, 9 Feb 2006 10:04:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ntl@pobox.com, dada1@cosmosbay.com, riel@redhat.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
       ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, pj@sgi.com
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-Id: <20060209100429.03f0b1c3.akpm@osdl.org>
In-Reply-To: <20060209090321.A9380@unix-os.sc.intel.com>
References: <20060209160808.GL18730@localhost.localdomain>
	<20060209090321.A9380@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> The problem was with ACPI just simply looking at the namespace doesnt
>  exactly give us an idea of how many processors are possible in this platform.

We need to fix this asap - the performance penalty for HOTPLUG_CPU=y,
NR_CPUS=lots will be appreciable.

Do any x86 platforms actually support CPU hotplug?

Does the ACPI problem which you describe occur with present-CPUs,
or only with possible-but-not-present ones?
