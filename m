Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131614AbRDJMVj>; Tue, 10 Apr 2001 08:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131625AbRDJMV3>; Tue, 10 Apr 2001 08:21:29 -0400
Received: from iris.mc.com ([192.233.16.119]:45002 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131614AbRDJMVP>;
	Tue, 10 Apr 2001 08:21:15 -0400
From: Mark Salisbury <mbs@mc.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mbs@mc.com (Mark Salisbury)
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:11:57 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: jdike@karaya.com (Jeff Dike), schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14mi1M-0002pU-00@the-village.bc.nu>
In-Reply-To: <E14mi1M-0002pU-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01041008131719.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Apr 2001, Alan Cox wrote:
> 
> Its worth doing even on the ancient x86 boards with the PIT. It does require
> some driver changes since
> 
> 
> 	while(time_before(jiffies, we_explode))
> 		poll_things();
> 
> no longer works

jiffies could be replaced easily enough w/ a macro such as

#define jiffies (get_time_in_jiffies())

then driver code would not need to be touched.

-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

