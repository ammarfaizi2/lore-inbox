Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130757AbRCEXV3>; Mon, 5 Mar 2001 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130759AbRCEXVT>; Mon, 5 Mar 2001 18:21:19 -0500
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:25103 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130757AbRCEXVH>; Mon, 5 Mar 2001 18:21:07 -0500
Date: Tue, 6 Mar 2001 12:21:04 +1300
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: The IO problem on multiple PCI busses
Message-ID: <20010306122104.B26306@metastasis.f00f.org>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com> <15006.40524.929644.25622@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15006.40524.929644.25622@pizda.ninka.net>; from davem@redhat.com on Thu, Mar 01, 2001 at 11:09:00AM -0800
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 11:09:00AM -0800, David S. Miller wrote:

    I think a cleaner scheme is to allow mmap() on
    /proc/bus/pci/${BUS}/${DEVICE} nodes, that is much cleaner and solves
    transparently any "different word size between userland and kernel"
    issues (specifically 32-bit userlands executing on 64-bit
    kernels).

This works great for when you want to do IO cycles from userland; but
what about the case of hardware which requires IO cycles from a
device driver for some very non-video hardware that may support
multiple cards across multiple busses?

Or do I not understand?



  --cw
