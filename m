Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVFICnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVFICnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVFICnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:43:47 -0400
Received: from smtp836.mail.sc5.yahoo.com ([66.163.171.23]:63167 "HELO
	smtp836.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262244AbVFICnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:43:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Adam Morley <adam.morley@gmail.com>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Date: Wed, 8 Jun 2005 21:43:34 -0500
User-Agent: KMail/1.8.1
References: <b70d73800506051924546c8931@mail.gmail.com> <b70d7380050608093138eb42df@mail.gmail.com> <b70d738005060819274653fd8@mail.gmail.com>
In-Reply-To: <b70d738005060819274653fd8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506082143.35199.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 21:27, Adam Morley wrote:
> On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> > Hi Dimitry,
> > 
> > On 6/8/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > On 6/8/05, Adam Morley <adam.morley@gmail.com> wrote:
> > > > Hi Dmitry,
> > > >
> > > > By Embedded Controller, do you mean CONFIG_ACPI_EC?  Because I can't
> > > > disable it w/o disable a bunch of ACPI modules, I think.
> > >
> > > As far as I remember EC is only required for smart battery supports.
> > > For testing purposes it is OK to not have it.
> > 
> > It seems that even when I set it to "# CONFIG_ACPI_EC is not set", it
> > gets re-enabled by make at some point.  I twiddled a couple of ACPI
> > modules off (save button), and it was still re-enabled.  I think I'd
> > have to disable ACPI.  I will play around with it some more though.
> 
> I'm still poking around trying to figure out how to disable
> CONFIG_ACPI_EC.  Once I get that done, I will post results.  Yeah, I
> can't get that to stay unset.  Every time I run make, I end up with it
> set to Y, even if I've disabled it before.

Try using "make menuconfig" to do that - Help should show you what
depends on EC.

-- 
Dmitry
