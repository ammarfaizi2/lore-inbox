Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbUAEBi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 20:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUAEBi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 20:38:58 -0500
Received: from main.gmane.org ([80.91.224.249]:63959 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265834AbUAEBi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 20:38:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: GCC 3.4 Heads-up
Date: Mon, 05 Jan 2004 02:38:54 +0100
Message-ID: <yw1xu13b2mz5.fsf@ford.guide>
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl>
 <3FF7A910.40703@tmr.com> <Pine.LNX.4.58.0401041232440.2162@home.osdl.org>
 <3FF8BDBB.4060708@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:L+7pdF/35qCXsKO94EZmWPMQ7J8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

>> If you have local variables (register or not), the sane thing to do is
>> 	if (a)
>> 		b = d;
>> 	else
>> 		c = d;
>> or variations on that. That's the readable code.
>
> But may lead to errors in maintenence. Your first example below avoids
> that problem. Imagine instead of "d" you have a 40-50 character
> RHS. Now imagine that the code needs to be changed. If you have the
> long expression in two places then it invites the possiblility of
> someone changing only one of them. You may never make mistakes, but
> the rest of us do, and the conditional LHS avoids that.

What's wrong with

	d = long_expression;
 	if (a)
 		b = d;
 	else
 		c = d;

Your long expression is still only in one place.

-- 
Måns Rullgård
mru@kth.se

