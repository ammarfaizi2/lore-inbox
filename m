Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTDRQpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbTDRQpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:45:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263146AbTDRQpH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:45:07 -0400
Message-ID: <3EA02E55.80103@pobox.com>
Date: Fri, 18 Apr 2003 12:56:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Trivial Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kstrdup
References: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304180919380.2950-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 18 Apr 2003, Jeff Garzik wrote:
> 
>>You should save the strlen result to a temp var, and then s/strcpy/memcpy/
> 
> 
> No, you should just not do this. I don't see the point.


strcpy has a test for each byte of its contents, and memcpy doesn't.
Why search 's' for NULL twice?

	Jeff



