Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131120AbQLZFVp>; Tue, 26 Dec 2000 00:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbQLZFVg>; Tue, 26 Dec 2000 00:21:36 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:14855
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131120AbQLZFV0>; Tue, 26 Dec 2000 00:21:26 -0500
Date: Tue, 26 Dec 2000 17:50:57 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Marco d'Itri" <md@Linux.IT>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001226175057.A12275@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012250131370.5340-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012250131370.5340-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 25, 2000 at 01:42:33AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 25, 2000 at 01:42:33AM -0800, Linus Torvalds wrote:

    We just don't write them out. Because right now the only thing
    that writes out dirty pages is memory pressure. "sync()",
    "fsync()" and "fdatasync()" will happily ignore dirty pages
    completely. The thing that made me overlook that simple thing in
    testing was that I was testing the new VM stuff under heavy VM
    load - to shake out any bugs.

Does this mean anyone using test13-pre4 should also expect to see
data not being flushed on shutdown? 

I'm not seeing data loss (or it's not obvious if I am) but wonder if
I should make a application to run before halt to allocate and walk
all available memory as an interim?



  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
