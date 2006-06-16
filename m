Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWFPLn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWFPLn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWFPLn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:43:56 -0400
Received: from ip57.73.1311O-CUD12K-02.ish.de ([62.143.73.57]:48306 "EHLO
	mocm.de") by vger.kernel.org with ESMTP id S1750732AbWFPLny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:43:54 -0400
From: Marcus Metzler <mocm@mocm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17554.39454.563004.916138@mocm.de>
Date: Fri, 16 Jun 2006 13:46:38 +0200
To: "Salvatore Sanfilippo" <antirez@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: v4l device in userspace
In-Reply-To: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
References: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
X-Mailer: VM 7.17 under 21.4 (patch 19) "Constant Variable" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Salvatore" == Salvatore Sanfilippo <antirez@gmail.com> writes:

    Salvatore> Hello, I'm trying to implement a v4l device driver for
    Salvatore> symbian based smart phones. In theory it is very
    Salvatore> simple:

    Salvatore> I've a little program running in the phone, capturing
    Salvatore> images from the camera and sending it to the linux box
    Salvatore> via bluetooth.

    Salvatore> In the linux box side, I've a deamon capturing this
    Salvatore> images (via a bluetooth SP channel), and....  I've to
    Salvatore> pass the images to a fake v4l device driver that
    Salvatore> actually gets the images form userspace.

    Salvatore> Basically I've to pass by the kernel just for the
    Salvatore> interface, and not to do real kernel-side work (like to
    Salvatore> access to the some kind of hardware).

    Salvatore> So I've some questions ( thanks in advance for any
    Salvatore> reply).

    Salvatore> 1) What's the best way to pass relatively high-band
    Salvatore> data between the v4l fake driver and userspace? A char
    Salvatore> device will do the work? ioctl?

    Salvatore> 2) What about some way to handle ioctl directly from
    Salvatore> userspace? Given this support I may implement the whole
    Salvatore> code in userspace.  And I guess there are a lot of
    Salvatore> other real world problems that can be handled in
    Salvatore> userspace given the ability to handle ioctl from there.

    Salvatore> If you think 2) is reasonable I may actually implement
    Salvatore> some simple form of generic char driver that just
    Salvatore> allows userspace programs to handle read/write/ioctl
    Salvatore> opreations, and then use this to fix my real issue.

    Salvatore> Thank you very much for the help, and sorry if there is
    Salvatore> something conceptually wrong in my questions.

Sounds like you should take a look at the v4l loopback device
(http://www.lavrsen.dk/twiki/bin/view/Motion/VideoFourLinuxLoopbackDevice).
Otherwise it may be better to ask the question on the v4l mailing list
(https://listman.redhat.com/mailman/listinfo/video4linux-list).

Anyway, since you already capture the video, why do you have to pipe
it through a v4l device? 

Marcus

-- 
/--------------------------------------------------------------------\
| Dr. Marcus O.C. Metzler        |                                   |
| mocm@metzlerbros.de            | http://www.metzlerbros.de/        |
\--------------------------------------------------------------------/
 |>>>             Quis custodiet ipsos custodes                 <<<|
