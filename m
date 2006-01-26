Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWAZM1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWAZM1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAZM1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:27:09 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:27993 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932307AbWAZM1I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:27:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hM0hC7zJGo4O3D3IryEmlFZFFkwcpiCf6Jvq6G0e11i3vr2uEcvu4N7i4ixQfyzwMxV5c/sHNApo+PYy3n7YOh1fJdG7Sowr7f/8YRjVycp3bwusevcELZfI/kP4D+MnBg/qXoJ/AqjAFQ/S3IxSCOCqTfkS0Lbnm5Lmae82BFw=
Message-ID: <3d53b7120601260427u5241e777x360e5088de6a4d3b@mail.gmail.com>
Date: Thu, 26 Jan 2006 17:57:07 +0530
From: Syed Ahemed <kingkhan@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Patch for CVE-2004-1334 ???
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060125220954.GW7142@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
	 <20060123191439.cfe5d61c.diegocg@gmail.com>
	 <3d53b7120601250056s77e876b6l2ac6781b8a9c9f00@mail.gmail.com>
	 <20060125220954.GW7142@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy.
Thanks a lot for the initiative , This is the brief list of
vulnerabilities i am concerned/aware about right now.Will keep looking
for patches in the days to come.
 Please feel free to ask for more help , I am ready to volunteer for
the cause of
making the open source kernel secure .

PS : Let me know the approach to get subsequent updates from you ?

1]http://www.openwall.com/linux/

 A] CAN-2004-1235
  Linux 2.4.29-ow1 is out. Linux 2.4.29, and thus 2.4.29-ow1, adds a
number of security fixes,   including to the x86/SMP page fault
handler (CAN-2005-0001) and the uselib(2)  (CAN-2004-1235) race
conditions, both discovered by Paul Starzetz. The potential of these 
bugs is a local root compromise. The uselib(2) bug does not affect
default builds of Linux kernels with the Openwall patch applied since
the vulnerable code is only compiled in if one explicitly enables
CONFIG_BINFMT_ELF_AOUT, an option introduced by the patch.


2] Same as above [CAN-2004-12345 but just fixes the uselib
vulnerabilty , I dont know again which one to pick

http://kerneltrap.org/node/4503
Marcelo Tosatti [interview] released the 2.4.29-rc1 Linux kernel with
"a SATA update [and a] bunch of network driver updates". He went on to
note, "more importantly it fixes a sys_uselib() vulnerability
discovered by Paul Starzetz". He adds, "[upgrading] is recommended for
users of v2.4.x mainline, distros should be releasing their updates
real soon now." The vulnerability allows local users to gain root
privileges:



3]  CAN-2004-1334
http://www.guninski.com/where_do_you_want_billg_to_go_today_2.html

http://linux.bkbits.net:8080/linux-2.4/cset@41b76e94BsJKm8jhVtyDat9ZM1dXXg
http://linux.bkbits.net:8080/linux-2.4/cset@41b766beodCDEFPbjDRLoUUUxw4Z6w
http://linux.bkbits.net:8080/linux-2.4/cset@41b77314ZtyUzWzZFzaCRGoQc6hKcw
http://linux.bkbits.net:8080/linux-2.4/cset@41c01f2bHFmPwBYQmce6Aw0owIyqkg



4] CAN-2004-1016

https://lwn.net/Articles/115726/



Thanks
King Khan

On 1/26/06, Willy Tarreau <willy@w.ods.org> wrote:
> On Wed, Jan 25, 2006 at 02:26:51PM +0530, Syed Ahemed wrote:
> > The simple reason we do not intend to use the latest version is we run
> > some third party software which cant be front ported (pardon the slang
> > ) to 2.4.29 and above.
> > As for the changeset by  guninski , i wish to ask about a one point
> > source of applying all the patches for 2.4.28 .I mean shouldn't all
> > the kernel security patches ( atleast the ones that have become CVE's)
> > be a part of kernel.org .Since there isn't any what is the reason ?
>
> It's even more work for the person doing it. Maintaining the hotfixes
> from 2.4.29 already takes me some time (not much more for 4 versions
> than for one, what takes the most time is merging the patches, compiling
> and releasing).
>
> > I dont want to go to Gentoo for one patch , red hat for another
> > ....and GOD knows how many sites .
> > Torvalds is the GOD of open source , but am i asking for too much :-)
>
> I can propose a deal to you. You send me a pointer to the patches that
> need to be applied to 2.4.28 to make it as secure as 2.4.29, and I can
> include 2.4.28 in my hotfix tree, so that you'll get regular updates
> for free. I already have what is needed starting from 2.4.29, you just
> have to point the 2.4.28-specific patches. It would time consuming for
> me to review them all, but if someone like you has some interest in it,
> it should be a win-win for both of us.
>
> Simply send me the bkbits.net URLs, I should be able to do the rest.
>
> Regards,
> Willy
>
>
