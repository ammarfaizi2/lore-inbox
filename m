Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbWC0NmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWC0NmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 08:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWC0NmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 08:42:25 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:18051 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751020AbWC0NmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 08:42:24 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: bus_add_device() losing an error return from the probe() method
To: Rene Herman <rene.herman@keyaccess.nl>, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, tiwai@suse.de, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 27 Mar 2006 15:41:37 +0200
References: <5TNbU-7Xn-17@gated-at.bofh.it> <5UsI5-Wf-9@gated-at.bofh.it> <5UM40-3Dy-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FNrz7-0001Cj-Nj@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
> Andrew Morton wrote:

>> Looks sane, but please don't sprinkle `return' statements all over a
>> function in this manner.
> 
> I actually prefer the multiple returns. You then don't have to "visually
> scroll down" to the label to see what would happen when reading the
> code. Even when there's common code before the return, I've never seen
> GCC not optimise that to the goto form itself. You obviously the boss
> though.

I tried both, and I found out that having multiple non-trivial points of
return enables you to easily create a lot of bugs.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
