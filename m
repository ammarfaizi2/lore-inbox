Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRAJQZd>; Wed, 10 Jan 2001 11:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132117AbRAJQZW>; Wed, 10 Jan 2001 11:25:22 -0500
Received: from nathan.polyware.nl ([193.67.144.241]:12549 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP
	id <S130370AbRAJQZL>; Wed, 10 Jan 2001 11:25:11 -0500
Date: Wed, 10 Jan 2001 17:25:05 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110172505.A32188@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelin@polyware.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110174859.R7498@prosa.it> <3A5C778C.CFB363F3@didntduck.org> <20010110180322.T7498@prosa.it> <20010110161146.A3252@unthought.net> <20010110182546.U7498@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010110182546.U7498@prosa.it>; from antirez@invece.org on Wed, Jan 10, 2001 at 06:25:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001 around 18:25:46 +0100, antirez wrote:
> On Wed, Jan 10, 2001 at 04:11:46PM +0100, Jakob ?stergaard wrote:
> > On most processors <<2 is slower than *4.   It's outright stupid to 
> > write <<2 when we mean *4 in order to optimize for one out of a
> > gazillion supported architectures - even more so when the compiler
> > for the one CPU where <<2 is faster, will actually generate a shift
> > instead of a multiply as a part of the standard optimization.
> 
> Hug, ok, so all the << 2 already in should be changed in *4.
> My point is that it is better to use only << 2 or *4, selecting
> the better form.

Well, better not change things so they look like:

#define	MSG_BLA1	(1<<1)
#define	MSG_BLA2	(1*4)
#define	MSG_BLA3	(1<<3)

as a result... :)

    Met vriendelijke groet,
        Pauline Middelink
-- 
GPG Key fingerprint = 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
