Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbRDQX62>; Tue, 17 Apr 2001 19:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132921AbRDQX6U>; Tue, 17 Apr 2001 19:58:20 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:58637 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132919AbRDQX6M>;
	Tue, 17 Apr 2001 19:58:12 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104172358.f3HNw60203153@saturn.cs.uml.edu>
Subject: Re: RFC: pageable kernel-segments
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 17 Apr 2001 19:58:05 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9bi53d$5n6$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 17, 2001 12:21:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
> By author:    "Heusden, Folkert van" <f.v.heusden@ftr.nl>

>> Would anyone be intrested (besides me) in a kernel which can page
...
>> Certain parts of drivers could get the __pageable prefix or so

> VMS does this.  It at least used to have a great tendency to crash
> itself, because it swapped out something that was called from a driver
> that was called by the swapper -- resulting in deadlock.  You need
> iron discipline for this to work right in all circumstances.
> 
> Second, it makes it quite hard to know what operations can cause a
> task to sleep, since any reference to paged-out memory can require a
> page-in and the associated schedule.  You almost need pointer
> annotation in order for this to be safe.

It wouldn't be nearly so dangerous to page from compressed
data in memory. The memory could be ROM.

