Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTDDUyC (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbTDDUyC (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:54:02 -0500
Received: from mail.zmailer.org ([62.240.94.4]:53478 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261317AbTDDUyB (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 15:54:01 -0500
Date: Sat, 5 Apr 2003 00:05:30 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: VGER's filters..
Message-ID: <20030404210530.GV29167@mea-ext.zmailer.org>
References: <20030404181054.GT29167@mea-ext.zmailer.org> <b6kqc4$2td$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6kqc4$2td$1@cesium.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 12:36:20PM -0800, H. Peter Anvin wrote:
> By author:    Matti Aarnio <matti.aarnio@zmailer.org>
> > <<-  MAIL FROM: <yahoo-dev-null@yahoo-inc.com>
> > ->>  501 5.1.7 strangeness between ':' and '<': <yahoo-dev-null@yahoo-inc.com>
...
> Sendmail, and a whole bunch of other mailers, have taken the more
> liberal approach of allowing any RFC 822-compliant address in this
> place (which is a *lot* more liberal than an RFC 821-compliant
> reverse-path.)  This is consistent with the "be liberal in what you
> accept, conservative in what you send" philosophy of network
> interoperability.

Definitely.  VGER is running fairly liberal mode, while some
other systems I run in extremely strict mode.   As a result,
vger lets in spams, which could be blocked by running strict.

> I suspect in Sendmail it naturally falls out of using a single set
> of canonicalization rules for all syntax.

Nope, the protocol line parser in original version was simple,
it reused same code for "MAIL FROM:" and "RCPT TO:" as for
"From:" and "To:", therefore with old sendmails you could
do in SMTP:
   MAIL FROM: < foo@bar >
   MAIL FROM:   foo@bar
and I think even:
   MAIL FROM: Example User foo@bar

There really was no SMTP protocol parser, there was just something
resembling it on surface.   (And tons of security problems...)

> 	-hpa

/Matti Aarnio
