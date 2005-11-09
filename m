Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbVKIWrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbVKIWrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbVKIWrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:47:19 -0500
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:36821 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1161001AbVKIWrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:47:18 -0500
Date: Wed, 9 Nov 2005 14:47:17 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>
cc: linas <linas@austin.ibm.com>, "J.A. Magallon" <jamagallon@able.es>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
In-Reply-To: <Pine.LNX.4.61.0511091723460.14236@chaos.analogic.com>
Message-ID: <Pine.LNX.4.58.0511091441070.16982@shell4.speakeasy.net>
References: <20051107204136.GG19593@austin.ibm.com>
 <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com>
 <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com>
 <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com>
 <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com> <20051109111640.757f399a@werewolf.auna.net>
 <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
 <20051109192028.GP19593@austin.ibm.com> <Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
 <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net>
 <Pine.LNX.4.61.0511091723460.14236@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trimmed linux-pci so as not to annoy those who don't want to listen to
all of this. Anyone else who wants off the CC list should yell also. :-)

On Wed, 9 Nov 2005, linux-os \(Dick Johnson\) wrote:

>
> On Wed, 9 Nov 2005, Vadim Lobanov wrote:
>
> > On Wed, 9 Nov 2005, linux-os \(Dick Johnson\) wrote:
> >
> >>
> >> On Wed, 9 Nov 2005, linas wrote:
> >>
> >>> On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to remark:
> >>>> On Wed, 9 Nov 2005, J.A. Magallon wrote:
> >>>>
> >>>>> void do_some_stuff(T& arg1,T&  arg2)
> >>>>
> >>>> A diligent C programmer would write this as follows:
> >>>> 	void do_some_stuff (struct T * a, struct T * b);
> >>>> So I don't see C++ winning at all here.
> >>>
> >>> I guess the real point that I'd wanted to make, and seems
> >>> to have gotten lost, was that by avoiding using pointers,
> >>> you end up designing code in a very different way, and you
> >>> can find out that often/usually, you don't need structs
> >>> filled with a zoo of pointers.
> >>>
> >>
> >> But you can't avoid pointers unless you make your entire
> >> program have global scope. That may be great for performance,
> >> but a killer if for have any bugs.
> >
>
> Maybe you tried to trick me by showing the variable was not going
> to be changed (const *). In that case, the compiler may not re-read
> the variable. However, it can re-read the variable.
>
> A "smart" compiler might just do: write(1, "0\n", 2);
> ... for the first printf() as well. Such compilers make
> debugging difficult.

It wasn't meant to be a trick. In fact, I _want_ the compiler to cache
the myvar value in the second case -- I was merely wondering if there
was some fact that I overlooked that would prevent such an optimization.
The ultimate point of this was to show that globals can actually be
slower than locals (imagine the int in the example replaced by a
gigantic struct), contrary to the implication of your original
statement. :-)

>
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
>
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
> Thank you.
>

-Vadim Lobanov
