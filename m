Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbTCTVxB>; Thu, 20 Mar 2003 16:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262642AbTCTVxB>; Thu, 20 Mar 2003 16:53:01 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:43949 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262623AbTCTVxA>; Thu, 20 Mar 2003 16:53:00 -0500
Date: Thu, 20 Mar 2003 14:03:13 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries.Brouwer@cwi.nl,
       akpm@digeo.com, andrey@eccentric.mae.cornell.edu,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: major/minor split
Message-ID: <20030320220313.GQ2835@ca-server1.us.oracle.com>
References: <UTC200303192140.h2JLeF924104.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303202146100.12110-100000@serv> <20030320214740.GP2835@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320214740.GP2835@ca-server1.us.oracle.com>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 01:47:41PM -0800, Joel Becker wrote:
> 	Actually, no.  mknod(8), ls(1), and friends still assume struct
> stat with u16.

	It's been pointed out to me that this isn't clear.  What I mean
is that mknod(8), ls(1), and other programs assume dev_t mappings that
are usually based upon the MAJOR() macro and friends.  This means that
any modification of the dev_t arrangement may require source fixes and
may not, depending on how smart MAJOR() is, but will absolutely require
a new compile of the software to pick up the new MAJOR() macro.
	Peter is right, we only want to do this once.

Joel

-- 

"There are some experiences in life which should not be demanded
 twice from any man, and one of them is listening to the Brahms Requiem."
        - George Bernard Shaw

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
