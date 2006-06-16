Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWFPLDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWFPLDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 07:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWFPLDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 07:03:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:33725 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751207AbWFPLDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 07:03:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gn08zDe8M/x/BGcR9UH+FCWrBBUmylnA2eYY4Gz0y+yY3GjfaiyRrW0ynivg1bQeSUJ2ZPT5xSzySbHrSlje7F6kte3oze6m+GP+tNiNyV6Kgftw8P57hsnwe2k433oDmuNSfrIvUoO4E8z2JRCtn0/FJLuFDC3extp8eyvSBnE=
Message-ID: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
Date: Fri, 16 Jun 2006 13:03:03 +0200
From: "Salvatore Sanfilippo" <antirez@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: v4l device in userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm trying to implement a v4l device driver
for symbian based smart phones. In theory
it is very simple:

I've a little program running in the phone, capturing
images from the camera and sending it to the
linux box via bluetooth.

In the linux box side, I've a deamon capturing this
images (via a bluetooth SP channel), and....
I've to pass the images to a fake v4l device
driver that actually gets the images form userspace.

Basically I've to pass by the kernel just for
the interface, and not to do real kernel-side work
(like to access to the some kind of hardware).

So I've some questions ( thanks in advance
for any reply).

1) What's the best way to pass relatively
high-band data between the v4l fake driver
and userspace? A char device will do the
work? ioctl?

2) What about some way to handle ioctl
directly from userspace? Given this support
I may implement the whole code in userspace.
And I guess there are a lot of other real world
problems that can be handled in userspace
given the ability to handle ioctl from there.

If you think 2) is reasonable I may actually
implement some simple form of generic
char driver that just allows userspace
programs to handle read/write/ioctl
opreations, and then use this to fix
my real issue.

Thank you very much for the help,
and sorry if there is something conceptually
wrong in my questions.

Regards,
Salvatore

P.S. please take me in CC as I'm not subscribed
to the linux kernel mailing list.

-- 
Salvatore 'antirez' Sanfilippo
We're programmers. Programmers are, in their hearts, architects -- Joel Spolsky
http://www.invece.org
