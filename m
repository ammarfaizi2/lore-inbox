Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbTCTVgy>; Thu, 20 Mar 2003 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbTCTVgy>; Thu, 20 Mar 2003 16:36:54 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:63702 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S262569AbTCTVgx>; Thu, 20 Mar 2003 16:36:53 -0500
Date: Thu, 20 Mar 2003 13:47:41 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, andrey@eccentric.mae.cornell.edu,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: major/minor split
Message-ID: <20030320214740.GP2835@ca-server1.us.oracle.com>
References: <UTC200303192140.h2JLeF924104.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202146100.12110-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303202146100.12110-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 10:00:48PM +0100, Roman Zippel wrote:
> There is a point I'd like to get clear: where should the 16bit<->32bit 
> dev_t conversion happen?
> I think any software that cares about this should be safe by now. That 
> leaves us with on-disk and on-wire formats and IMO only at these places a 
> conversion should happen.

	Actually, no.  mknod(8), ls(1), and friends still assume struct
stat with u16.

Joel

-- 

"Every new beginning comes from some other beginning's end."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
