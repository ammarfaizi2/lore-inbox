Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTENUza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbTENUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:55:30 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:53266 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id S262798AbTENUz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:55:26 -0400
Date: Wed, 14 May 2003 13:58:47 -0700
To: Ahmed Masud <masud@googgun.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030514205847.GA18514@bluemug.com>
Mail-Followup-To: Ahmed Masud <masud@googgun.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Yoav Weiss <ml-lkml@unpatched.org>, linux-kernel@vger.kernel.org
References: <20030514074403.GA18152@bluemug.com> <Pine.LNX.4.33.0305140608070.10480-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305140608070.10480-100000@marauder.googgun.com>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 06:34:30AM -0400, Ahmed Masud wrote:
> 
> Level of security is a matter of trust.  Should the kernel trust a
> distribution provider? No, that is not a reasonable request, because we do
> not control their environment and evaluation proceedures and there are no
> guarentees between the channel that provides the operating system to the
> time it gets installed on a system.

I don't understand why people are willing to base security arguments
on some sort of bizarre adversarial relationship between the kernel and
the system tools.

No Unix (even a "secure" one) is designed to run all security-critical
code in the kernel.  That would be a bad design anyway, since it would
run lots of code at an unwarranted privilege level.  "login" is not
part of the kernel.  "su" is not part of the kernel".  The boot loader
is not part of the kernel.  And so on.

There is no issue of "trust" between the kernel and the distribution
provider.  The distribution provider provides a system, which (like all
Unix-derived systems) is modular and thus has multiple independent
components with security functions.  The sum of those parts is what you
should evaluate for security.  Yes, the system should include proper
isolation mechanisms to prevent improper privilege escalations.  But it
doesn't make sense to even think about what the kernel should do when
the untrusted distribution provides a malicious "/sbin/init".

miket
