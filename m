Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275841AbRJBHCy>; Tue, 2 Oct 2001 03:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275845AbRJBHCn>; Tue, 2 Oct 2001 03:02:43 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:45719 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S275841AbRJBHCb>; Tue, 2 Oct 2001 03:02:31 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110020702.IAA22663@mauve.demon.co.uk>
Subject: Re: [PATCH] Stateful Magic Sysrq Key
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Oct 2001 08:02:37 +0100 (BST)
In-Reply-To: <20011001234437.A10994@mueller.datastacks.com> from "Crutcher Dunnavant" at Oct 01, 2001 11:44:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch is a reworked patch which originated from Amazon.
> It makes the sysrq key stateful, giving it the following behaviours:

IMO, this is needed for broken keyboards, but in this exact form will
cause problems for those without them.
Pressing alt-sysrq accidentally is rare, but happens, typically when 
I'm going for vt-12 in a hurry, or cleaning out crumbs.
Normally this is fairly harmless, as most of the dangerous keys are
on a different quadrant.
Making it sticky makes accidents much more likely.

I'd suggest either making this behaviour optional, or making it so that
hitting alt-sysrq twice, without any other keys being pressed makes the
next key stick.

