Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSG2HHx>; Mon, 29 Jul 2002 03:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318064AbSG2HHx>; Mon, 29 Jul 2002 03:07:53 -0400
Received: from mail.medav.de ([213.95.12.190]:20496 "HELO mail.medav.de")
	by vger.kernel.org with SMTP id <S316900AbSG2HHw> convert rfc822-to-8bit;
	Mon, 29 Jul 2002 03:07:52 -0400
From: "Daniela Engert" <dani@ngrt.de>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Lionel Bouton" <Lionel.Bouton@inet6.fr>
Date: Mon, 29 Jul 2002 09:11:34 +0200 (CDT)
Reply-To: "Daniela Engert" <dani@ngrt.de>
X-Mailer: PMMail 2.00.1500 for OS/2 Warp 4.05
In-Reply-To: <3D448052.4070805@inet6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Re: SiS 5513 ATA133 support patch for 2.4.19-rc3-ac3
Message-Id: <20020729070252.9F16E1107A@mail.medav.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2002 01:37:54 +0200, Lionel Bouton wrote:

>Today I received a report for v0.13 with a *645* ID for a 645DX. This ID 
>is recognised as only ATA100-capable -> data corruption occured (problem 
>solved with v0.14).
>
>Before releasing 2.4.19 I think we should either :
>- completely remove the affected northbridges (645, 650, 745, 750) 
>support in v0.13, this is a simple patch. Then we wait for 2.4.20 to 
>include v0.14.

Lionel,

as you already figured out, looking at the northbridge IDs is simply
not sufficient to find out which capabilities and register layout the
IDE controller in the southbridge (no matter if integrated or external)
has.

Some comments:

1) the 745 has an integrated southbridge and an ATA/100 capable IDE
controller

2) the 646 (and most likely the 645 and others as well) may be paired
with a 961 (ATA/100) or 961B (ATA133) MutIOL southbridge with different
register programming values.

Thus simply ripping out some northbridge IDs wouldn't prevent
corruption problems.

Ciao,
  Dani

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Daniela Engert, systems engineer at MEDAV GmbH
Gräfenberger Str. 34, 91080 Uttenreuth, Germany
Phone ++49-9131-583-348, Fax ++49-9131-583-11


