Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282823AbRLTJlO>; Thu, 20 Dec 2001 04:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLTJlF>; Thu, 20 Dec 2001 04:41:05 -0500
Received: from camus.xss.co.at ([194.152.162.19]:16908 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S282640AbRLTJkq>;
	Thu, 20 Dec 2001 04:40:46 -0500
Message-ID: <3C21B21A.DF8110F2@xss.co.at>
Date: Thu, 20 Dec 2001 10:40:42 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: linux-kernel@vger.kernel.org, monika@xss.co.at
Subject: Re: Deadlock: Linux-2.2.18, sym53c8xx, Compaq ProLiant, HP Ultrium
In-Reply-To: <20011219191306.Y1668-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gérard,

thanks for your reply!

Gérard Roudier wrote:
> 
> On Wed, 19 Dec 2001, Andreas Haumer wrote:
> 
[...]
> 
> > Dec 10 15:00:01 server kernel: st0: Error with sense data: Info
> > fld=0x8000, Current st09:00: sense key Hardware Error
> > Dec 10 15:00:01 server kernel: Additional sense indicates Internal
> > target failure
> 
> This one is the result of a REQUEST SENSE performed due probably to a
> CHECK condition SCSI status reported by the device. It is not a SCSI
> transport problem. The device just reports an error to the application
> client. This is not a normal situation but happens very often.
> 
Ok.

> > [...]
> >
> >    After that, the amanda process hangs in state "D" and
> >    cannot be killed anymore. The machine itself is still
> >    working.
> >    This _seems_ to be the indication of an error of the
> >    HP Ultrium itself, though the drive works quite fine
> >    otherwise...
> 
> The 'D' states indicates that the process is waiting for something without
> being interruptible. This may be due to it not having been waken up on the

I knew that...

> IO error. The sym53c8xx driver did its work by performing the REQUEST
> SENSE, but something in upper layer seem not to complete the IO.
> 
That's what I wasn't sure about...

[...]
> 
> > b) Does the st0 error message indicate it should be replaced?
> 
> Probably not. But it is very poor an information about the real issue.
> 
I know, but I have the problem to decide how to proceed in this
situation...

> > c) Is there a bug in the sym53c8xx driver which makes the
> >    amanda process hang uninterruptable when this error occurs?
> 
> Not known. But possible, even if in my opinion, the driver is not at
> fault.
> 
Ok.

[...]
> 
> There are probably still bugs in the driver, but none are intentionnal,
> beleive me.
> 
I honestly do believe you! :-)

> > The Ultrium hardware error is not reproducable at will. It
> > just happens every now and then.
> > Next thing I will try is to use a different SCSI controller
> > (Adaptec 29160 or the like) to see if the hanging process
> > occurs with a different SCSI driver, too.
> 
> This is indeed something to try.
> I am very interested in the result.
> 
The controller change is scheduled on December 28th.
We'll then see how it works in the next weeks/months.
I'll keep you (and LKML) informend...

Thank you.

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
