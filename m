Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFFQ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFFQ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:29:04 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:24521 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261970AbTFFQ3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:29:02 -0400
Message-ID: <3EE0C45B.4070002@colorfullife.com>
Date: Fri, 06 Jun 2003 18:42:03 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ameya.mitragotri@wipro.com
CC: wli@holomorphy.com, linux-kernel@vger.kernel.org, davej@suse.de,
       indou.takao@jp.fujitsu.com, akpm@diego.com
Subject: Re: [RFC][PATCH 2.5.70] dynamically tunable semmnu and semume
References: <200306061141.50965.ameya.mitragotri@wipro.com>
In-Reply-To: <200306061141.50965.ameya.mitragotri@wipro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ameya Mitragotri wrote:

>Find below the patch (RFC) that makes semmnu and semume dynamically
>tunable through /proc. 
>
AFAICS the patch implements semmnu and semume, correct? The current 
implemention permits an unlimited number of undo structures.

1) Why do you want to introduce a limit? Have you found a potential DoS?
2) What is counted by semume? Individual undo entries, or undo arrays? 
Linux differs from the normal unix sysv implementation: there is a per 
process, per semaphore set array of undo entries.

--
    Manfred

