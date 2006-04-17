Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDQKp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDQKp4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 06:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWDQKp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 06:45:56 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:10633 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750748AbWDQKpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 06:45:55 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: want to randomly drop packets based on percent
To: George Nychis <gnychis@cmu.edu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 17 Apr 2006 12:45:29 +0200
References: <62wv1-U5-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1FVREs-0000bf-I1@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Nychis <gnychis@cmu.edu> wrote:

> But then I ran into the problem of properly seeding the random number
> generator... srand(time(0)) is one way... however time() returns
> seconds, therefore i would drop multiple packets in a single second if I
> used this method which is very undesirable.  What is the proper way to
> generate a random number here?

You seed the random generator once, not each time you use it.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
