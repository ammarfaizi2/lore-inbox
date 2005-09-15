Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030417AbVION3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030417AbVION3p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbVION3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:29:45 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:60887 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1030417AbVION3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:29:44 -0400
Message-ID: <432976E0.4030003@cs.aau.dk>
Date: Thu, 15 Sep 2005 15:28:00 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Automatic Configuration of a Kernel
References: <20050915130201.95797.qmail@web51002.mail.yahoo.com>
In-Reply-To: <20050915130201.95797.qmail@web51002.mail.yahoo.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmad Reza Cheraghi wrote:
> 
> If the script want to ask some question, what will be
> the difference if we write make config.

The main difference will be that the options without "auto" flag
or where the script said "n" will be skipped.

It will reduce quite considerably the number of questions.

The algorithm is quite simple:

If (no "auto" field) ---> go for the default

If ("auto" field) --->
	script gives n  --->  go for "n"
	script gives y  --->  ask for [y/n]
	script gives y/m -->  ask for [y/m/n]

That's all folks...

Regards
-- 
Emmanuel Fleury

Assistant Professor          | Office: B1-201
Computer Science Department, | Phone:  +45 96 35 72 23
Aalborg University,          | Mobile: +45 26 22 98 03
Fredriks Bajersvej 7E,       | E-mail: fleury@cs.aau.dk
9220 Aalborg East, Denmark   | URL: www.cs.aau.dk/~fleury
