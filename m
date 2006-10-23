Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWJWHTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWJWHTH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWJWHTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:19:07 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:39510
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750948AbWJWHTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:19:04 -0400
Message-Id: <453C8966.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 23 Oct 2006 08:20:38 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@suse.de>
Cc: "Magnus Damm" <magnus@valinux.co.jp>, <linux-kernel@vger.kernel.org>,
       <patches@x86-64.org>, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patches] [PATCH] [18/19] x86_64: Overlapping program
	headers in physical addr space fix
References: <20061021 651.356252000@suse.de>
 <20061021165138.B8B5E13C4D@wotan.suse.de>
In-Reply-To: <20061021165138.B8B5E13C4D@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>@@ -17,6 +17,7 @@ PHDRS {
> 	text PT_LOAD FLAGS(5);	/* R_E */
> 	data PT_LOAD FLAGS(7);	/* RWE */
> 	user PT_LOAD FLAGS(7);	/* RWE */
>+	data.init PT_LOAD FLAGS(7);	/* RWE */
> 	note PT_NOTE FLAGS(4);	/* R__ */
> }
> SECTIONS

Even though it's only cosmetic, I think it would have been
more than appropriate to remove the ill 'E' permission on data
with that change. (Btw., why does 'note' need 'R'?) Also, I
consider the naming of the new segment misleading - just 'init'
would have been more correct.

Jan

