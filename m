Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277264AbRJDW7w>; Thu, 4 Oct 2001 18:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJDW7n>; Thu, 4 Oct 2001 18:59:43 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:6831 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277257AbRJDW7b>;
	Thu, 4 Oct 2001 18:59:31 -0400
Date: Thu, 04 Oct 2001 23:59:56 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: specific optimizations for unaccelerated framebuffers
Message-ID: <308217942.1002239996@[195.224.237.69]>
In-Reply-To: <20011004142803.72199.qmail@web11806.mail.yahoo.com>
In-Reply-To: <20011004142803.72199.qmail@web11806.mail.yahoo.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 04 October, 2001 4:28 PM +0200 Etienne Lorrain 
<etienne_lorrain@yahoo.fr> wrote:

>> Since anything less than 75Hz gives me headaches, how do you propose to
>> make this work?
>
>   Because there is still memory on the video board, the display stay
>  at whatever refresh the video board is set up, 80 Hz if you want.

A long time ago (tm) I used this approach successfully. It
involved using an (onboard) display controller with a limited
dotclock doing large resolution high bpp displays (but at
10 to 20 Hz), capturing the digital output in offboard Video
RAM, and displaying it at 90Hz. You get some slight artefacts
but in general worked well. And here I was copying the
whole screen each time. If you only copy changed areas,
you'd ge much better results.

--
Alex Bligh
