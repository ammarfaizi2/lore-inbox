Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129663AbQKZQIg>; Sun, 26 Nov 2000 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132068AbQKZQI1>; Sun, 26 Nov 2000 11:08:27 -0500
Received: from maild.telia.com ([194.22.190.3]:38663 "EHLO maild.telia.com")
        by vger.kernel.org with ESMTP id <S131434AbQKZQIR>;
        Sun, 26 Nov 2000 11:08:17 -0500
From: Anders Torger <torger@ludd.luth.se>
Reply-To: torger@ludd.luth.se
Organization: -
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
Date: Sun, 26 Nov 2000 16:36:38 +0100
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <00112614213105.05228@paganini> <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0011261636380A.05228@paganini>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, you wrote:
> On Sun, Nov 26, 2000 at 02:21:31PM +0100, Anders Torger wrote:
> > 	memcpy_toio(iobase, user_space_src, count);
>
> I hope count isn't provided by userspace here ?

Fortunately, 'count' is controlled by the driver architecture (ALSA), and not 
the user.

> > 1. What happens if the user space memory is swapped to disk? Will
> > verify_area() make sure that the memory is in physical RAM when it
> > returns, or will it return -EFAULT, or will something even worse happen?
>
> On i386, you'll sleep implicitly waiting for the page fault to be handled; 
> in the generic case, anything could happen.

Do you know of an architecture that will not do like i386 in this case?

> > 2. Is this code really portable? I currently have an I386 architecture,
> > and I could use copy_to/from_user on that instead, but that is not
> > portable. Now, by using memcpy_to/fromio instead, is this code fully
> > portable?
>
> No.  It would be portable if you were using memcpy_fromuser_toio and it
> existed.

Oh, I see. Again, I wonder, do you know of any architecture, currently 
supported by Linux, where my code would fail? It would be helpful to know.

/Anders Torger
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
