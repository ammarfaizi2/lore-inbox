Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVFUNbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVFUNbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVFUNbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:31:35 -0400
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:22163 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261476AbVFUNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:30:25 -0400
Message-ID: <01ea01c5766c$be955390$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Willy Tarreau" <willy@w.ods.org>, "J.A. Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org> <1117232503l.24619l.1l@werewolf.able.es> <20050621125404.GA13437@alpha.home.local>
Subject: Re: Kill signed chars !!! => PPC uses unsigned chars
Date: Tue, 21 Jun 2005 10:23:01 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The signedness of 'char' is never certain between compilers.  There are x86
C compilers that implemented 'char' as unsigned, others as signed, and
others that offered a compile switch to do either way if the default didn't
work with the code being compiled.

When it matters, just be explicit :)

----- Original Message ----- 
From: "Willy Tarreau" <willy@w.ods.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: <linux-kernel@vger.kernel.org>; "Andrew Morton" <akpm@osdl.org>
Sent: Tuesday, June 21, 2005 08:54
Subject: Re: Kill signed chars !!! => PPC uses unsigned chars

>
> Well, to my surprize, linux-ppc uses UNSIGNED chars by default. It has
amazed
> me but it's a fact. Let's compile this little program on tux-ppc :

