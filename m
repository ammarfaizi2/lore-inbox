Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290653AbSARKN1>; Fri, 18 Jan 2002 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290654AbSARKNW>; Fri, 18 Jan 2002 05:13:22 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:22792 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S290653AbSARKNJ>; Fri, 18 Jan 2002 05:13:09 -0500
Message-ID: <3C47F528.3C39E31@aitel.hist.no>
Date: Fri, 18 Jan 2002 11:12:56 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Walton <lawrence@the-penguin.otak.com>,
        linux-kernel@vger.kernel.org
Subject: Re: DEVFS broken?
In-Reply-To: <20020117171229.GA1084@the-penguin.otak.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton wrote:
> 
> I am not sure how to debug this but it apears that
> in 2.5.3-pre1 and in 2.5.2-dj1 DEVFS is not working.
> It started by terminals hanging and not being able to
> shutdown.
> I went to /dev/ and did a ls, it compleatly hangs that
> terminal and I cannot kill ls.
> I have the devfsd version from debian 1.3.21 .

I run into that inability to shutdown occationally.
There is an easy fix though:

kill -SIGUSR1 1
This is the documented way of dealing with a
remounted /dev.  shutdown, init, telinit
work normally after that.  Unless there
are other errors of course.

Helge Hafting
