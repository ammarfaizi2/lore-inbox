Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135859AbRAJPZi>; Wed, 10 Jan 2001 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135927AbRAJPZ2>; Wed, 10 Jan 2001 10:25:28 -0500
Received: from smtp2.libero.it ([193.70.192.52]:17405 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S135859AbRAJPZO>;
	Wed, 10 Jan 2001 10:25:14 -0500
Date: Wed, 10 Jan 2001 18:25:46 +0100
From: antirez <antirez@invece.org>
To: Jakob ?stergaard <jakob@unthought.net>, antirez <antirez@invece.org>,
        Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110182546.U7498@prosa.it>
Reply-To: antirez@invece.org
In-Reply-To: <20010110174859.R7498@prosa.it> <3A5C778C.CFB363F3@didntduck.org> <20010110180322.T7498@prosa.it> <20010110161146.A3252@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110161146.A3252@unthought.net>; from jakob@unthought.net on Wed, Jan 10, 2001 at 04:11:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 04:11:46PM +0100, Jakob ?stergaard wrote:
> On most processors <<2 is slower than *4.   It's outright stupid to 
> write <<2 when we mean *4 in order to optimize for one out of a
> gazillion supported architectures - even more so when the compiler
> for the one CPU where <<2 is faster, will actually generate a shift
> instead of a multiply as a part of the standard optimization.

Hug, ok, so all the << 2 already in should be changed in *4.
My point is that it is better to use only << 2 or *4, selecting
the better form.

-- 
Salvatore Sanfilippo              |                      <antirez@invece.org>
http://www.kyuzz.org/antirez      |      PGP: finger antirez@tella.alicom.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
