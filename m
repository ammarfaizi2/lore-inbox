Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130299AbRAQUWP>; Wed, 17 Jan 2001 15:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131894AbRAQUWG>; Wed, 17 Jan 2001 15:22:06 -0500
Received: from adsl-63-194-89-126.dsl.snfc21.pacbell.net ([63.194.89.126]:41232
	"HELO skull.piratehaven.org") by vger.kernel.org with SMTP
	id <S130299AbRAQUVw>; Wed, 17 Jan 2001 15:21:52 -0500
Date: Wed, 17 Jan 2001 12:17:19 -0800
From: Brian Pomerantz <bapper@piratehaven.org>
To: Rick Richardson <rick@remotepoint.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc() of 4MB causes "kernel BUG at slab.c:1542!"
Message-ID: <20010117121719.A29786@skull.piratehaven.org>
Mail-Followup-To: Brian Pomerantz <bapper@piratehaven.org>,
	Rick Richardson <rick@remotepoint.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010117135420.A3536@remotepoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117135420.A3536@remotepoint.com>; from rick@remotepoint.com on Wed, Jan 17, 2001 at 01:54:20PM -0600
X-homepage: http://www.piratehaven.org/~bapper/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 01:54:20PM -0600, Rick Richardson wrote:
> 
> [please cc me on any responses]
> 
> Environment: 2.4.0 released, Pentium III with 256MB's of RAM.
> Problem:  kmalloc() of 4M causes kernel message "kernel BUG at slab.c:1542"
> 

The most you can kmalloc() is 128KB unless this has changed in the 2.4
kernel which I doubt.  If you want a region of memory that large, use
vmalloc().  Of course, this doesn't guarantee a contiguous region.


BAPper
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
